import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wallet/base/base_bloc.dart';
import 'package:wallet/models/balance.dart';
import 'package:wallet/models/currency.dart';

class HomeBloc extends BaseBloc {
  final _balanceController = BehaviorSubject<Balance>.seeded(
    const Balance(
      balance: 20000,
      spending: 500,
      income: 3000,
      bills: 800,
      savings: 1000,
    ),
  );
  final _currencyDictController = BehaviorSubject<List<Currency>>.seeded([
    const Currency(
      curCode: "USD",
      title: "US Dollar",
      flagPath: 'packages/country_code_picker/flags/us.png',
    ),
    const Currency(
      curCode: "MNT",
      title: "MN Tugrik",
      flagPath: 'packages/country_code_picker/flags/mn.png',
    ),
  ]);
  final _selectedCurrencyController = BehaviorSubject<Currency>.seeded(
    const Currency(
      curCode: "USD",
      title: "US Dollar",
      flagPath: 'packages/country_code_picker/flags/us.png',
    ),
  );

  Function(Currency) get changeCurrency => _selectedCurrencyController.sink.add;

  Stream<Balance> get balanceStream => _balanceController.stream;
  Stream<List<Currency>> get currencyDictStream =>
      _currencyDictController.stream;
  Stream<Currency> get currencyStream => _selectedCurrencyController.stream;

  Future<void> getAddition(BuildContext context) async {}

  @override
  void dispose() {
    _balanceController.close();
    _currencyDictController.close();
  }
}
