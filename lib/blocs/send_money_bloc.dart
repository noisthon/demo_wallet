import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wallet/base/base_bloc.dart';
import 'package:wallet/screens/transaction_complete.screen.dart';
import 'package:wallet/utils/extensions.dart';
import 'package:wallet/utils/mixin.dart';

class SendMoneyBloc extends BaseBloc with ValidationMixin {
  final _amtController = BehaviorSubject<String>();
  final _stepController = BehaviorSubject<int>.seeded(0);

  Function(String) get changeAmt => _amtController.sink.add;

  Stream<int> get stepStream => _stepController.stream;
  Stream<String> get amtStream => _amtController.stream;

  Stream<String?> get amtErrorStream => _amtController.stream.validateWith([
        requiredValidator(),
      ]);
  Stream<bool> get isAmtValid => Rx.combineLatestList([
        amtErrorStream,
      ]).map((errors) => errors.every((error) => error == null)).distinct();

  void navToPrevStep() {
    _stepController.sink.add(_stepController.value - 1);
  }

  void navToNextStep() {
    _stepController.sink.add(_stepController.value + 1);
  }

  void onPay(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        TransactionCompleteScreen.routeName, (a) => a.isFirst);
  }

  @override
  void dispose() {
    _amtController.close();
    _stepController.close();
  }
}
