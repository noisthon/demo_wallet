import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wallet/blocs/sign_up_bloc.dart';
import 'package:wallet/style/theme.dart';
import 'package:wallet/utils/extensions.dart';

class VerifyMobileNoDialog extends StatelessWidget {
  const VerifyMobileNoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignUpBloc>();
    return AlertDialog(
      icon: const CircleAvatar(radius: 75),
      title: "Verify your phone number before we send code"
          .text(24500, color: Colors.black),
      content: StreamBuilder(
        stream: Rx.combineLatest2(
          bloc.regionCodeStream,
          bloc.mobileNoStream,
          (a, b) => "$a $b",
        ),
        builder: (context, asyncSnapshot) {
          return RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Is this correct? ",
                  style: 15400.style(color: MyColor.grey),
                ),
                TextSpan(
                  text: asyncSnapshot.data ?? "",
                  style: 16500.style(color: MyColor.grey),
                ),
              ],
            ),
          );
        },
      ),
      actions: [
        Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: "Yes".txt),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: "No".txt),
            )
          ],
        ),
      ],
    );
  }
}
