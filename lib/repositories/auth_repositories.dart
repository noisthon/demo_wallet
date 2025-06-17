import 'package:hive_flutter/adapters.dart';
import 'package:wallet/models/user.dart';

class UserRepositories {
  Future<User> signUp(
      String regionCode, String mobileNo, String password, String otp) async {
    final box = await Hive.openBox<User>("auth");
    final existingUser = box.get(regionCode + mobileNo);
    
    if(existingUser != null){
      throw "User already exist";
    }

    final user = User(mobileNo: mobileNo, password: password);
    
    await box.put(
        regionCode + mobileNo, User(mobileNo: mobileNo, password: password));
    return user;
  }

  Future<User?> signIn(
      String regionCode, String mobileNo, String password) async {
    final box = await Hive.openBox<User>("auth");
    final user = box.get(regionCode + mobileNo);
    return user;
  }
}
