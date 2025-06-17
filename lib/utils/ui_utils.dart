import 'package:flutter/material.dart';

abstract interface class UIUtils {
  static callback(void Function(Duration duration) callback) {
    WidgetsBinding.instance
        .addPostFrameCallback((duration) => callback(duration));
  }

  static Color colorFromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static void hideKeyboard(BuildContext context) {
    callback((_) {
      FocusScope.of(context).unfocus();
    });
  }
}
