import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  @HiveType(typeId: 0)
  const factory User({
    @HiveField(0) required String regionCode,
    @HiveField(1) required String mobileNo,
    @HiveField(2) required String password,
    @HiveField(3) required bool hasAddition,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
