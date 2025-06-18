import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wallet/base/base_bloc.dart';
import 'package:wallet/models/additional_info.dart';
import 'package:wallet/models/user.dart';
import 'package:wallet/style/theme.dart';

class AppBloc extends BaseBloc {
  final _authUserController = BehaviorSubject<User?>();
  final _additionalInfoController = BehaviorSubject<AdditionalInfo?>();
  final _themeController =
      BehaviorSubject<ThemeData>.seeded(MyTheme.defaultTheme);

  late final StreamSubscription authUserSubscription =
      authUserStream.listen((authUser) {
    if (authUser != null && authUser.hasAddition) {
      getAddition();
    }
  });

  Stream<AdditionalInfo?> get additionalInfoStream =>
      _additionalInfoController.stream;
  Stream<User?> get authUserStream => _authUserController.stream;
  Stream<ThemeData> get themeStream => _themeController.stream;
  Stream<bool> get authStateStream =>
      _authUserController.stream.map<bool>((user) => user != null).distinct();

  User get authUser => _authUserController.value!;
  AdditionalInfo get additionalInfo => _additionalInfoController.value!;

  void authenticate(User user) {
    _authUserController.add(user);
  }

  void signOut() {
    _authUserController.add(null);
  }

  Future<void> getAddition() async {
    final result = await repository.getAdditionInfo(
      regionCode: authUser.regionCode,
      mobileNo: authUser.mobileNo,
    );
    _additionalInfoController.sink.add(result);
  }

  @override
  void dispose() {
    _authUserController.close();
    _authUserController.close();
    _additionalInfoController.close();
    authUserSubscription.cancel();
  }
}
