import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/blocs/sign_up_bloc.dart';
import 'package:wallet/utils/ui_utils.dart';
import 'package:wallet/widgets/app_bar.dart';
import 'package:wallet/widgets/sign_up/sign_up_step_create_account.dart';
import 'package:wallet/widgets/sign_up/sign_up_step_verify_number.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "SignUp";
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final PageController pageController;
  late final SignUpBloc bloc;

  StreamSubscription? _stepChangeListener;

  @override
  void initState() {
    bloc = context.read();
    pageController = PageController();
    _stepChangeListener = bloc.stepStream.listen(onStepChanged);
    super.initState();
  }

  @override
  void dispose() {
    _stepChangeListener?.cancel();
    super.dispose();
  }

  void onStepChanged(SignUpStep data) {
    UIUtils.hideKeyboard(context);
    switch (data) {
      case SignUpStep.create:
        if (pageController.page?.round() == 1) {
          pageController.animateToPage(0,
              duration: Durations.medium2, curve: Curves.easeIn);
        }
        break;
      case SignUpStep.validate:
        if (pageController.page?.round() == 0) {
          pageController.animateToPage(1,
              duration: Durations.medium2, curve: Curves.easeIn);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.stepStream,
        builder: (context, asyncSnapshot) {
          return PopScope(
            canPop: asyncSnapshot.data == SignUpStep.create,
            onPopInvokedWithResult: (didPop, result) {
              if (asyncSnapshot.data == SignUpStep.validate) {
                bloc.navToCreate();
              }
            },
            child: Scaffold(
              appBar: const MyAppBar(),
              body: PageView(
                controller: pageController,
                children: const [
                  SignUpStepCreateAccount(),
                  SignUpStepVerifyNumber(),
                ],
              ),
            ),
          );
        });
  }
}
