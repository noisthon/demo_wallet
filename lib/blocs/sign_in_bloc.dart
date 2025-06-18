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

class SignInBloc extends BaseBloc with ValidationMixin {
  final _regionCodeController = BehaviorSubject<String>.seeded("+976");
  final _mobileNoController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Function(String) get changeRegionCode => _regionCodeController.sink.add;
  Function(String) get changeMobileNo => _mobileNoController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  Stream<String> get regionCodeStream => _regionCodeController.stream;
  Stream<String> get mobileNoStream => _mobileNoController.stream;
  Stream<String> get passwordStream => _passwordController.stream;

  Stream<String?> get mobileNoErrorStream =>
      _mobileNoController.stream.validateWith([
        requiredValidator(),
        minLength(5),
        // mobileNoValidator(),
      ]);

  Stream<String?> get passwordErrorStream =>
      _passwordController.stream.validateWith([
        requiredValidator(),
        minLength(6),
        // maxLength(12),
      ]);

  Stream<bool> get isValid => Rx.combineLatestList([
        mobileNoErrorStream,
        passwordErrorStream,
      ]).map((errors) => errors.every((error) => error == null)).distinct();

  void onSignIn(BuildContext context) async {
    try {
      final user = await repository.signIn(_regionCodeController.value,
          _mobileNoController.value, _passwordController.value);
      final appBloc = context.read<AppBloc>();
      appBloc.authenticate(user);
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
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
  }
}
