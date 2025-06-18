import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wallet/base/base_bloc.dart';
import 'package:wallet/blocs/app_bloc.dart';
import 'package:wallet/repositories/auth_repositories.dart';
import 'package:wallet/utils/extensions.dart';
import 'package:wallet/utils/mixin.dart';
import 'package:wallet/widgets/sign_up/verify_mobile_no_dialog.dart';

class SignUpBloc extends BaseBloc with ValidationMixin {
  final _regionCodeController = BehaviorSubject<String>.seeded("+976");
  final _mobileNoController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _otpController = BehaviorSubject<String>();
  final _stepController = BehaviorSubject<int>.seeded(0);

  Function(String) get changeRegionCode => _regionCodeController.sink.add;
  Function(String) get changeMobileNo => _mobileNoController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeOtp => _otpController.sink.add;

  Stream<int> get stepStream => _stepController.stream;
  Stream<String> get regionCodeStream => _regionCodeController.stream;
  Stream<String> get mobileNoStream => _mobileNoController.stream;
  Stream<String> get passwordStream => _passwordController.stream;

  Stream<String?> get mobileNoErrorStream =>
      _mobileNoController.stream.validateWith([
        requiredValidator(),
        numeric(),
        minLength(5),
        maxLength(15),
        // mobileNoValidator(),
      ]);

  Stream<String?> get otpErrorStream => _otpController.stream.validateWith([
        requiredValidator(),
        length(6),
      ]);

  Stream<String?> get passwordErrorStream =>
      _passwordController.stream.validateWith([
        requiredValidator(),
        minLength(6),
        // maxLength(12),
      ]);

  Stream<bool> get isCreateAccountStepValid => Rx.combineLatestList([
        mobileNoErrorStream,
        passwordErrorStream,
      ]).map((errors) => errors.every((error) => error == null)).distinct();

  Stream<bool> get isOtpStepValid => Rx.combineLatestList([
        otpErrorStream,
      ]).map((errors) => errors.every((error) => error == null)).distinct();

  void onValidateMobileNo(BuildContext context) async {
    final verifyDialogResult = await showDialog<bool>(
      context: context,
      builder: (context) => Provider.value(
        value: this,
        child: const VerifyMobileNoDialog(),
      ),
    );

    if (verifyDialogResult ?? false) {
      navToNextStep();
    }
  }

  void navToPrevStep() {
    _stepController.sink.add(_stepController.value - 1);
  }

  void navToNextStep() {
    _stepController.sink.add(_stepController.value + 1);
  }

  void onSignUp(BuildContext context) async {
    final appBloc = context.read<AppBloc>();
    try {
      final user = await repository.signUp(
          _regionCodeController.value,
          _mobileNoController.value,
          _passwordController.value,
          _otpController.value);
      appBloc.authenticate(user);
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  void dispose() {
    _regionCodeController.close();
    _mobileNoController.close();
    _passwordController.close();
    _otpController.close();
    _stepController.close();
  }
}
