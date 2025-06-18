import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/blocs/sign_in_bloc.dart';
import 'package:wallet/style/theme.dart';
import 'package:wallet/utils/extensions.dart';
import 'package:wallet/widgets/app_bar.dart';

class SignInScreen extends StatelessWidget {
  static const routeName = "SignIn";
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignInBloc>();
    return Scaffold(
      appBar: const MyAppBar(),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Log in to Coinpay".text(30700, color: Colors.black),
              "Enter Vour registered mobile number to log in".txt,
              const SizedBox(height: 24),
              "Phone".label,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: MyColor.lightGrey,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: CountryCodePicker(
                      initialSelection: "+976",
                      onChanged: (value) =>
                          bloc.changeRegionCode(value.dialCode ?? "+976"),
                      builder: (countryCode) {
                        if (countryCode == null) {
                          return const SizedBox.shrink();
                        }
                        return Row(
                          children: [
                            if (countryCode.flagUri != null)
                              Expanded(
                                child: Image.asset(
                                  "packages/country_code_picker/${countryCode.flagUri!}",
                                ),
                              ),
                            const SizedBox(width: 4),
                            countryCode.dialCode?.text(15500) ??
                                const SizedBox.shrink()
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: StreamBuilder(
                      stream: bloc.mobileNoErrorStream,
                      builder: (context, asyncSnapshot) {
                        return TextFormField(
                          onChanged: (v) {
                            bloc.changeMobileNo(v);
                          },
                          decoration: InputDecoration(
                            hintText: "Mobile number",
                            errorText: asyncSnapshot.data,
                          ),
                          buildCounter: (context,
                                  {required currentLength,
                                  required isFocused,
                                  required maxLength}) =>
                              null,
                          maxLength: 15,
                          keyboardType: TextInputType.number,
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              "Password".label,
              StreamBuilder(
                  stream: bloc.passwordErrorStream,
                  builder: (context, asyncSnapshot) {
                    return TextFormField(
                      onChanged: bloc.changePassword,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        errorText: asyncSnapshot.data,
                        hintText: "••••••••",
                      ),
                      buildCounter: (context,
                              {required currentLength,
                              required isFocused,
                              required maxLength}) =>
                          null,
                      maxLength: 12,
                      obscureText: true,
                    );
                  }),
              const SizedBox(height: 12),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Forgot password?",
                    style: const TextStyle(color: MyColor.primary),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, "Terms");
                      },
                  )),
              const Spacer(),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: Builder(builder: (context) {
                  return StreamBuilder(
                    stream: bloc.isValid,
                    builder: (context, snapshot) {
                      return ElevatedButton(
                        onPressed: snapshot.data ?? false
                            ? () => bloc.onSignIn(context)
                            : null,
                        child: "Sign up".txt,
                      );
                    },
                  );
                }),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
