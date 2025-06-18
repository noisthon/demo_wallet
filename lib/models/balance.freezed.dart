// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'balance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Balance {
  double get balance => throw _privateConstructorUsedError;
  double get spending => throw _privateConstructorUsedError;
  double get income => throw _privateConstructorUsedError;
  double get bills => throw _privateConstructorUsedError;
  double get savings => throw _privateConstructorUsedError;

  /// Create a copy of Balance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BalanceCopyWith<Balance> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BalanceCopyWith<$Res> {
  factory $BalanceCopyWith(Balance value, $Res Function(Balance) then) =
      _$BalanceCopyWithImpl<$Res, Balance>;
  @useResult
  $Res call(
      {double balance,
      double spending,
      double income,
      double bills,
      double savings});
}

/// @nodoc
class _$BalanceCopyWithImpl<$Res, $Val extends Balance>
    implements $BalanceCopyWith<$Res> {
  _$BalanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Balance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balance = null,
    Object? spending = null,
    Object? income = null,
    Object? bills = null,
    Object? savings = null,
  }) {
    return _then(_value.copyWith(
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      spending: null == spending
          ? _value.spending
          : spending // ignore: cast_nullable_to_non_nullable
              as double,
      income: null == income
          ? _value.income
          : income // ignore: cast_nullable_to_non_nullable
              as double,
      bills: null == bills
          ? _value.bills
          : bills // ignore: cast_nullable_to_non_nullable
              as double,
      savings: null == savings
          ? _value.savings
          : savings // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BalanceImplCopyWith<$Res> implements $BalanceCopyWith<$Res> {
  factory _$$BalanceImplCopyWith(
          _$BalanceImpl value, $Res Function(_$BalanceImpl) then) =
      __$$BalanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double balance,
      double spending,
      double income,
      double bills,
      double savings});
}

/// @nodoc
class __$$BalanceImplCopyWithImpl<$Res>
    extends _$BalanceCopyWithImpl<$Res, _$BalanceImpl>
    implements _$$BalanceImplCopyWith<$Res> {
  __$$BalanceImplCopyWithImpl(
      _$BalanceImpl _value, $Res Function(_$BalanceImpl) _then)
      : super(_value, _then);

  /// Create a copy of Balance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balance = null,
    Object? spending = null,
    Object? income = null,
    Object? bills = null,
    Object? savings = null,
  }) {
    return _then(_$BalanceImpl(
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      spending: null == spending
          ? _value.spending
          : spending // ignore: cast_nullable_to_non_nullable
              as double,
      income: null == income
          ? _value.income
          : income // ignore: cast_nullable_to_non_nullable
              as double,
      bills: null == bills
          ? _value.bills
          : bills // ignore: cast_nullable_to_non_nullable
              as double,
      savings: null == savings
          ? _value.savings
          : savings // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$BalanceImpl implements _Balance {
  const _$BalanceImpl(
      {required this.balance,
      required this.spending,
      required this.income,
      required this.bills,
      required this.savings});

  @override
  final double balance;
  @override
  final double spending;
  @override
  final double income;
  @override
  final double bills;
  @override
  final double savings;

  @override
  String toString() {
    return 'Balance(balance: $balance, spending: $spending, income: $income, bills: $bills, savings: $savings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BalanceImpl &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.spending, spending) ||
                other.spending == spending) &&
            (identical(other.income, income) || other.income == income) &&
            (identical(other.bills, bills) || other.bills == bills) &&
            (identical(other.savings, savings) || other.savings == savings));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, balance, spending, income, bills, savings);

  /// Create a copy of Balance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BalanceImplCopyWith<_$BalanceImpl> get copyWith =>
      __$$BalanceImplCopyWithImpl<_$BalanceImpl>(this, _$identity);
}

abstract class _Balance implements Balance {
  const factory _Balance(
      {required final double balance,
      required final double spending,
      required final double income,
      required final double bills,
      required final double savings}) = _$BalanceImpl;

  @override
  double get balance;
  @override
  double get spending;
  @override
  double get income;
  @override
  double get bills;
  @override
  double get savings;

  /// Create a copy of Balance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BalanceImplCopyWith<_$BalanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
