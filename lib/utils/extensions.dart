import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
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

extension ReDesignStringToWidget on String {
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
      style: style,
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
