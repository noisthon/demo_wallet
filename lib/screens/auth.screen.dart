import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wallet/main.dart';
import 'package:wallet/screens/sign_in.screen.dart';
import 'package:wallet/screens/sign_up.screen.dart';
import 'package:wallet/style/theme.dart';
import 'package:wallet/utils/extensions.dart';
import 'package:wallet/widgets/app_bar.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = "Auth";
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Padding(
        padding: const EdgeInsetsGeometry.all(24),
        child: Column(
          children: [
            const Expanded(child: Placeholder()),
            const SizedBox(height: 32),
            "Create your\nCoinpay account"
                .text(30700, textAlign: TextAlign.center),
            const SizedBox(height: 32),
            "Coinpay is a powerful tool that allows you to easily send, receive, and track all your transactions."
                .widget(textAlign: TextAlign.center),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(SignUpScreen.routeName);
                },
                child: "Sign up".txt,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(SignInScreen.routeName);
                },
                child: "Log in".txt,
              ),
            ),
            const SizedBox(height: 32),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: const TextStyle(color: Colors.black),
                    children: [
                      const TextSpan(text: "By continuing you accept our\n"),
                      TextSpan(
                        text: "Terms of Service",
                        style: const TextStyle(color: MyColor.primary),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, "Terms");
                          },
                      ),
                      const TextSpan(text: " and "),
                      TextSpan(
                        text: "Privacy Policy",
                        style: const TextStyle(color: MyColor.primary),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, "Policy");
                          },
                      ),
                    ])),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
