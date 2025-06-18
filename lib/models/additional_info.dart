import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'additional_info.g.dart';
part 'additional_info.freezed.dart';

@freezed
class AdditionalInfo with _$AdditionalInfo {
  @HiveType(typeId: 1)
  const factory AdditionalInfo({
    @HiveField(0) required String email,
    @HiveField(1) required String addressLine,
    @HiveField(2) required String city,
    @HiveField(3) required String postCode,
    @HiveField(4) required String residence,
    @HiveField(5) required String fullNameLine,
    @HiveField(6) required String username,
    @HiveField(7) required DateTime birthDate,
  }) = _AdditionalInfo;

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) =>
      _$AdditionalInfoFromJson(json);
}
