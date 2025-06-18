// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdditionalInfoImplAdapter extends TypeAdapter<_$AdditionalInfoImpl> {
  @override
  final int typeId = 1;

  @override
  _$AdditionalInfoImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$AdditionalInfoImpl(
      email: fields[0] as String,
      addressLine: fields[1] as String,
      city: fields[2] as String,
      postCode: fields[3] as String,
      residence: fields[4] as String,
      fullNameLine: fields[5] as String,
      username: fields[6] as String,
      birthDate: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, _$AdditionalInfoImpl obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.addressLine)
      ..writeByte(2)
      ..write(obj.city)
      ..writeByte(3)
      ..write(obj.postCode)
      ..writeByte(4)
      ..write(obj.residence)
      ..writeByte(5)
      ..write(obj.fullNameLine)
      ..writeByte(6)
      ..write(obj.username)
      ..writeByte(7)
      ..write(obj.birthDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdditionalInfoImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdditionalInfoImpl _$$AdditionalInfoImplFromJson(Map<String, dynamic> json) =>
    _$AdditionalInfoImpl(
      email: json['email'] as String,
      addressLine: json['addressLine'] as String,
      city: json['city'] as String,
      postCode: json['postCode'] as String,
      residence: json['residence'] as String,
      fullNameLine: json['fullNameLine'] as String,
      username: json['username'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
    );

Map<String, dynamic> _$$AdditionalInfoImplToJson(
        _$AdditionalInfoImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'addressLine': instance.addressLine,
      'city': instance.city,
      'postCode': instance.postCode,
      'residence': instance.residence,
      'fullNameLine': instance.fullNameLine,
      'username': instance.username,
      'birthDate': instance.birthDate.toIso8601String(),
    };
