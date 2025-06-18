import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/blocs/send_money_bloc.dart';
import 'package:wallet/models/currency.dart';
import 'package:wallet/screens/send_modey.screen.dart';
import 'package:wallet/style/theme.dart';
import 'package:wallet/utils/extensions.dart';
import 'package:wallet/widgets/send_money/choose_recipient.dart';

class TransactionCompleteScreen extends StatelessWidget {
  static const routeName = "TransactionComplete";
  const TransactionCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Color(0xFFe9f5e9),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.check_circle_rounded,
                        color: Color(0xFF1a5e21),
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 4),
                    "Transaction Complete! - 01 Jan 2023 at 5:00 pm"
                        .text(13500, color: Color(0xFF1a5e21)),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                color: Colors.white,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(radius: 40),
                      mehadi.name.text(17500),
                      mehadi.email.text(14400),
                      "Coinpoy Transaction ID: JD890KQ".text(
                        14400,
                        color: MyColor.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 36),
            "Choose Account".label,
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: Card(
                color: Colors.white,
                elevation: 0,
                child: ListTile(
                  leading: Container(
                    height: 20,
                    width: 30,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: MyColor.lightGrey,
                        ),
                        borderRadius: BorderRadius.circular(6)),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 1.5,
                          left: 3,
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: const BoxDecoration(
                                color: Colors.amber, shape: BoxShape.circle),
                          ),
                        ),
                        Positioned(
                          top: 1.5,
                          right: 3,
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: const BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                          ),
                        ),
                      ],
                    ),
                  ),
                  title: "Account *****************3994".txt,
                ),
              ),
            ),
            const SizedBox(height: 36),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.popUntil(context, (p) => p.isFirst);
                    },
                    child: "Back to Homepage".txt,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        SendModeyScreen.routeName,
                      );
                    },
                    child: "Make another Payment".txt,
                  ),
                ),
              ],
            )),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(color: Colors.black),
                children: [
                  const TextSpan(
                      text:
                          "Thank you for using our app to send money. If you have any questions or concerns, please don't hesitate to "),
                  TextSpan(
                    text: "contact us.",
                    style: const TextStyle(color: MyColor.primary),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print('Hello World');
                      },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}
