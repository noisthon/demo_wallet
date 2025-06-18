import 'dart:math' as math;

import 'package:intl/intl.dart';
import 'package:intl/number_symbols.dart';
import 'package:wallet/utils/extensions.dart';

enum FormatType {
  titleCase,
  lowerCase,
  upperCase,
}

class Formatter {
  static String date(
    DateTime? date, {
    String pattern = 'MM/dd/yyyy',
  }) {
    if (date == null) return '';
    final DateFormat formatter = DateFormat(pattern);
    return formatter.format(date);
  }

  static String dateTime(
    DateTime? date, {
    String pattern = 'MM/dd/yyyy hh:mm:ss',
  }) {
    if (date == null) return '';
    final DateFormat formatter = DateFormat(pattern);
    return formatter.format(date);
  }

  /// Double iig formatlana curCode damjuulj bolno
  static String currency(double number,
      {String? pattern, int maxFractionLength = 2, String? curCode}) {
    if (pattern != null) {
      final NumberFormat formatter = NumberFormat(pattern);
      return '${getCurrencySymbol(curCode)}${formatter.format(number)}';
    }

    String fractionStr = '$number'.split('.')[1];
    int? fraction =
        fractionStr.length == 1 ? int.tryParse(fractionStr) ?? 0 : null;

    if (fraction != null && fraction == 0) {
      pattern = '#,###';
      final NumberFormat formatter = NumberFormat(pattern);
      return getCurrencySymbol(curCode) + formatter.format(number);
    }

    String fractionPattern = List.generate(
            math.min(fractionStr.length, maxFractionLength), (_) => '#')
        .reduce((a, b) => "$a$b");
    pattern = '#,###.$fractionPattern';
    final NumberFormat formatter = NumberFormat(pattern);
    return getCurrencySymbol(curCode) + formatter.format(number);
  }

  static String getCurrencySymbol(String? curCode) {
    switch (curCode?.format(formatType: FormatType.upperCase)) {
      case 'MNT':
        return '₮';
      case 'EUR':
        return '€';
      case 'USD':
        return '\$';
      default:
        return '';
    }
  }

  static String string(
    String? str, {
    FormatType formatType = FormatType.titleCase,
  }) {
    if (str == null) return '';

    str = str.trim();
    switch (formatType) {
      case FormatType.upperCase:
        str = str.toUpperCase();
        break;
      case FormatType.lowerCase:
        str = str.toLowerCase();
        break;
      case FormatType.titleCase:
        str = str.toLowerCase();
        str = "${str[0].toUpperCase()}${str.substring(1)}";
        break;
    }

    return str;
  }
}
