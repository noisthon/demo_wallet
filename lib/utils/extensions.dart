import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wallet/utils/parser.dart';

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
}
