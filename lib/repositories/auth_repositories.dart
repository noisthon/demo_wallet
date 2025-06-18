import 'package:hive_flutter/adapters.dart';
import 'package:wallet/models/additional_info.dart';
import 'package:wallet/models/user.dart';

class Repository {
  static const _instance = Repository._();
  const Repository._();
  factory Repository() => _instance;

  Future<User> signUp(
      String regionCode, String mobileNo, String password, String otp) async {
    final box = await Hive.openBox<User>("auth");
    final existingUser = box.get(regionCode + mobileNo);

    if (existingUser != null) {
      throw "User already exist";
    }

    final user = User(
        regionCode: regionCode,
        mobileNo: mobileNo,
        password: password,
        hasAddition: false);

    await box.put(regionCode + mobileNo, user);
    return user;
  }

  Future<User> updateAddition(
      String regionCode, String mobileNo, bool hasAddition) async {
    final box = await Hive.openBox<User>("auth");
    final user = box.get(regionCode + mobileNo);
    if (user == null) {
      throw "User not found";
    }
    final newUser = user.copyWith(hasAddition: hasAddition);
    await box.put(regionCode + mobileNo, newUser);
    return newUser;
  }

  Future<User?> signIn(
      String regionCode, String mobileNo, String password) async {
    final box = await Hive.openBox<User>("auth");
    final user = box.get(regionCode + mobileNo);
    return user;
  }

  Future<AdditionalInfo> updateAdditionInfo({
    required String regionCode,
    required String mobileNo,
    required String email,
    required String addressLine,
    required String city,
    required String postCode,
    required String residence,
    required String fullNameLine,
    required String username,
    required DateTime birthDate,
  }) async {
    final box = await Hive.openBox<AdditionalInfo>("addition");

    final addition = AdditionalInfo(
      addressLine: addressLine,
      birthDate: birthDate,
      city: city,
      email: email,
      fullNameLine: fullNameLine,
      postCode: postCode,
      residence: residence,
      username: username,
    );

    await box.put(regionCode + mobileNo, addition);
    return addition;
  }

  Future<AdditionalInfo> getAdditionInfo({
    required String regionCode,
    required String mobileNo,
  }) async {
    final box = await Hive.openBox<AdditionalInfo>("addition");

    final addition = box.get(regionCode + mobileNo);
    if (addition == null) {
      throw "No additional info";
    }
    return addition;
  }
}
