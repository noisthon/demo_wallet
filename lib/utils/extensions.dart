import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wallet/utils/formatter.dart';
import 'package:wallet/utils/parser.dart';

extension StreamValidation<T> on Stream<T> {
  Stream<String?> validateWith(List<String? Function(T value)> validators) {
    return map((value) {
      for (var validator in validators) {
        final error = validator(value);
        if (error != null) {
          return error;
        }
      }
      return null;
    });
  }

  Stream<String?> validateWithDebounced(
    List<String? Function(T value)> validators, {
    Duration debounceDuration = const Duration(milliseconds: 300),
  }) {
    return debounceTime(debounceDuration).map((value) {
      for (var validator in validators) {
        final error = validator(value);
        if (error != null) {
          return error;
        }
      }
      return null;
    });
  }
}

extension FormatDouble on double {
  String format(
      {String? pattern, int maxFractionLength = 2, String curCode = ""}) {
    return Formatter.currency(toDouble(),
            pattern: pattern,
            maxFractionLength: maxFractionLength,
            curCode: curCode)
        .replaceAll(' ', '');
  }

  String get toPercent => "$this%";
}

extension DateTimeFormatterExtension on DateTime {
  String format({
    String pattern = 'MM/dd/yyyy',
  }) {
    if (this == DateTime(0)) return "";
    return Formatter.date(this, pattern: pattern);
  }

  String formatWithTime({String pattern = "MM/dd/yyyy hh:mm:ss"}) {
    if (this == DateTime(0)) return "";
    return Formatter.date(this, pattern: pattern);
  }
}

extension ReDesignStringToWidget on String {
  String format({
    FormatType formatType = FormatType.titleCase,
  }) {
    return Formatter.string(this, formatType: formatType);
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
      default:
        return str;
    }

    return str;
  }

  Widget text(
    int size, {
    Color? color,
    Key? key,
    List<String> args = const [],
    Map<String, String>? namedArgs,
    String? gender,
    TextStyle? style,
    InlineSpan? textSpan,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    String? prefix,
    TextOverflow? overflow,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
  }) {
    final fontSize = (size ~/ 1000).toDouble();
    final fontWeight = Parser.parseFontWeight(size % 1000);

    return Text(
      this,
      key: key,
      style: style != null
          ? style.copyWith(
              fontSize: style.fontSize ?? fontSize,
              fontWeight: style.fontWeight ?? fontWeight,
              color: style.color ?? color,
            )
          : TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: color,
            ),
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }

  Widget widget({
    Color? color,
    Key? key,
    List<String> args = const [],
    Map<String, String>? namedArgs,
    String? gender,
    TextStyle? style,
    InlineSpan? textSpan,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    String? prefix,
    TextOverflow? overflow,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
  }) {
    return Text(
      this,
      key: key,
      style: style != null
          ? style.copyWith(
              color: style.color ?? color,
            )
          : TextStyle(
              color: color,
            ),
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }

  Widget get label {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        this,
        style: 15400.style(color: Colors.black),
      ),
    );
  }

  Widget get txt {
    return Text(
      this,
    );
  }
}

extension ReDesignIntToStyle on int {
  TextStyle style({
    TextStyle? style,
    Color? color,
  }) {
    final fontSize = (this ~/ 1000).toDouble();
    final fontWeight = Parser.parseFontWeight(this % 1000);

    return style != null
        ? style.copyWith(
            fontSize: style.fontSize ?? fontSize,
            fontWeight: style.fontWeight ?? fontWeight,
            color: style.color ?? color,
          )
        : TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
          );
  }
}
