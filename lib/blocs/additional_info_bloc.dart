import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wallet/base/base_bloc.dart';
import 'package:wallet/blocs/app_bloc.dart';
import 'package:wallet/utils/extensions.dart';
import 'package:wallet/utils/mixin.dart';

enum AdditionalInfoStep {
  email(0),
  address(1);

  const AdditionalInfoStep(this.stepNumber);
  final int stepNumber;
}

class AdditionalInfoBloc extends BaseBloc with ValidationMixin {
  final _stepController = BehaviorSubject<int>.seeded(0);
  final _emailController = BehaviorSubject<String>();
  final _addressLineController = BehaviorSubject<String>();
  final _cityController = BehaviorSubject<String>();
  final _postCodeController = BehaviorSubject<String>();
  final _residenceController = BehaviorSubject<String>();
  final _fullNameLineController = BehaviorSubject<String>();
  final _usernameController = BehaviorSubject<String>();
  final _birthDateController = BehaviorSubject<DateTime>();

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeAddressLine => _addressLineController.sink.add;
  Function(String) get changeCity => _cityController.sink.add;
  Function(String) get changePostCode => _postCodeController.sink.add;
  Function(String) get changeFullNameLine => _fullNameLineController.sink.add;
  Function(String) get changeUsername => _usernameController.sink.add;
  Function(String) get changeResidence => _residenceController.sink.add;
  Function(DateTime) get changeBirthDate => _birthDateController.sink.add;

  Stream<String?> get emailErrorStream => _emailController.stream.validateWith([
        requiredValidator(),
        emailValidator(),
      ]);

  Stream<String?> get addressLineErrorStream =>
      _addressLineController.stream.validateWith([
        requiredValidator(),
      ]);

  Stream<String?> get cityErrorStream => _cityController.stream.validateWith([
        requiredValidator(),
      ]);

  Stream<String?> get postCodeErrorStream =>
      _postCodeController.stream.validateWith([
        requiredValidator(),
      ]);
  Stream<String?> get fullNameLineErrorStream =>
      _fullNameLineController.stream.validateWith([
        requiredValidator(),
      ]);

  Stream<String?> get usernameErrorStream =>
      _usernameController.stream.validateWith([
        requiredValidator(),
        minLength(3),
      ]);

  Stream<String?> get birthDateErrorStream =>
      _birthDateController.stream.validateWith([
        requiredValidator(),
      ]);
  Stream<String?> get residenceErrorStream =>
      _residenceController.stream.validateWith([
        requiredValidator(),
      ]);

  Stream<int> get stepStream => _stepController.stream;
  Stream<DateTime> get birthDateStream => _birthDateController.stream;
  Stream<String> get residenceStream => _residenceController.stream;

  Stream<bool> get isAddEmailStepValid => Rx.combineLatestList([
        emailErrorStream,
      ]).map((errors) => errors.every((error) => error == null)).distinct();
  Stream<bool> get isHomeAddressValid => Rx.combineLatestList([
        addressLineErrorStream,
        cityErrorStream,
        postCodeErrorStream,
      ]).map((errors) => errors.every((error) => error == null)).distinct();
  Stream<bool> get isPersonalInfoStepValid => Rx.combineLatestList([
        fullNameLineErrorStream,
        usernameErrorStream,
        birthDateErrorStream,
      ]).map((errors) => errors.every((error) => error == null)).distinct();
  Stream<bool> get isCountryResidenceStepValid => Rx.combineLatestList([
        residenceErrorStream,
      ]).map((errors) => errors.every((error) => error == null)).distinct();

  void navToPrevStep() {
    _stepController.sink.add(_stepController.value - 1);
  }

  void navToNextStep() {
    _stepController.sink.add(_stepController.value + 1);
  }

  Future<void> updateAdditionInfo(BuildContext context) async {
    try {
      final appBloc = context.read<AppBloc>();
      await repository.updateAdditionInfo(
        regionCode: appBloc.authUser.regionCode,
        mobileNo: appBloc.authUser.mobileNo,
        email: _emailController.value,
        addressLine: _addressLineController.value,
        city: _cityController.value,
        postCode: _postCodeController.value,
        residence: _residenceController.value,
        fullNameLine: _fullNameLineController.value,
        username: _usernameController.value,
        birthDate: _birthDateController.value,
      );

      final newUser = await repository.updateAddition(
        appBloc.authUser.regionCode,
        appBloc.authUser.mobileNo,
        true,
      );
      appBloc.authenticate(newUser);
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
    _stepController.close();
    _emailController.close();
    _addressLineController.close();
    _cityController.close();
    _postCodeController.close();
    _residenceController.close();
    _fullNameLineController.close();
    _usernameController.close();
    _birthDateController.close();
  }
}
