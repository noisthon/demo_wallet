import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipient.freezed.dart';

@freezed
class Recipient with _$Recipient{
  const factory Recipient({
    required String name,
    required String email,
  }) = _Recipient;
}