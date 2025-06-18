import 'package:freezed_annotation/freezed_annotation.dart';

part 'balance.freezed.dart';

@freezed
class Balance with _$Balance{
  const factory Balance({
    required double balance,
    required double spending,
    required double income,
    required double bills,
    required double savings,
    
  }) = _Balance;
}