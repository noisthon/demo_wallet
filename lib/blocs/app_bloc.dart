import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wallet/base/base_bloc.dart';
import 'package:wallet/models/user.dart';
import 'package:wallet/style/theme.dart';

class AppBloc implements BaseBloc {
  final _authUserController = BehaviorSubject<User?>();
  final _themeController =
      BehaviorSubject<ThemeData>.seeded(MyTheme.defaultTheme);

  Stream<User?> get authUserStream => _authUserController.stream;
  Stream<ThemeData> get themeStream => _themeController.stream;
  Stream<bool> get authStateStream =>
      _authUserController.stream.map<bool>((user) => user != null).distinct();

  void authenticate(User user) {
    _authUserController.add(user);
  }

  void signOut() {
    _authUserController.add(null);
  }

  @override
  void dispose() {}
}
