// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserImplAdapter extends TypeAdapter<_$UserImpl> {
  @override
  final int typeId = 0;

  @override
  _$UserImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$UserImpl(
      regionCode: fields[0] as String,
      mobileNo: fields[1] as String,
      password: fields[2] as String,
      hasAddition: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, _$UserImpl obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.regionCode)
      ..writeByte(1)
      ..write(obj.mobileNo)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.hasAddition);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      regionCode: json['regionCode'] as String,
      mobileNo: json['mobileNo'] as String,
      password: json['password'] as String,
      hasAddition: json['hasAddition'] as bool,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'regionCode': instance.regionCode,
      'mobileNo': instance.mobileNo,
      'password': instance.password,
      'hasAddition': instance.hasAddition,
    };
