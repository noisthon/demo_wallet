import 'package:flutter/material.dart';
import 'package:wallet/widgets/app_bar.dart';
import 'package:wallet/widgets/sign_up/sign_up_step_create_account.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "SignUp";
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: PageView(
        controller: pageController,
        children: [const SignUpStepCreateAccount()],
      ),
    );
  }
}
