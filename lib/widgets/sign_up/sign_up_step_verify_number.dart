import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wallet/blocs/sign_up_bloc.dart';
import 'package:wallet/main.dart';
import 'package:wallet/style/theme.dart';
import 'package:wallet/utils/extensions.dart';

class SignUpStepVerifyNumber extends StatelessWidget {
  const SignUpStepVerifyNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignUpBloc>();
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Confirm your phone".text(30700, color: Colors.black),
            StreamBuilder(
                stream: Rx.combineLatest2(
                  bloc.regionCodeStream,
                  bloc.mobileNoStream,
                  (a, b) => "$a $b",
                ),
                builder: (context, asyncSnapshot) {
                  return "we send 6 digits code to ${asyncSnapshot.data ?? ""}"
                      .txt;
                }),
            const SizedBox(height: 48),
            OtpTextField(
              numberOfFields: 6,
              focusedBorderColor: MyColor.primary,
              showFieldAsBox: false,
              borderWidth: 2.0,
              onCodeChanged: bloc.changeOtp,
              onSubmit: bloc.changeOtp,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: 15500.style(color: MyColor.grey),
                  children: [
                    const TextSpan(text: "Didn't get a code? "),
                    TextSpan(
                      text: "Resend",
                      style: const TextStyle(color: MyColor.primary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('Hello World');
                        },
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: Builder(builder: (context) {
                return StreamBuilder(
                  stream: bloc.isOtpStepValid,
                  builder: (context, snapshot) {
                    return ElevatedButton(
                      onPressed: snapshot.data ?? false
                          ? () => bloc.onSignUp(context)
                          : null,
                      child: "Verify Your Number".txt,
                    );
                  },
                );
              }),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
