import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency.freezed.dart';

@freezed
class Currency with _$Currency {
  const factory Currency({
    required String curCode,
    required String title,
    required String flagPath,
  }) = _Currency;
}
