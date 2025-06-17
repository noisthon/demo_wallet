import 'package:flutter/widgets.dart';

abstract class Parser {
  // Nullable parseruud
  //-----------------------------------
  static String? parseStringNullable(Object? object) {
    if (object == null) return null;
    return object.toString().trim();
  }

  static double? parseDoubleNullable(Object? object) {
    if (object == null) return null;

    double? val =
        double.tryParse(object.toString().replaceAll(RegExp(r"[,']"), ""));

    return val;
  }

  static int? parseIntNullable(Object? object) {
    if (object == null) return null;

    int? val = int.tryParse(object.toString().replaceAll(RegExp(r"[,']"), ""));

    return val;
  }

  static DateTime? parseDateTimeNullable(
    Object? object,
  ) {
    if (object == null) return null;

    DateTime? val = DateTime.tryParse(object.toString().length > 10
        ? object.toString()
        : object.toString().replaceAll(".", "-"));

    return val;
  }

  static List<T>? parseListNullable<T>(
      [dynamic map, T Function(Map<String, dynamic>?)? converter]) {
    if (map is List && converter != null) {
      return List<T>.from(map.map((x) => converter(x as Map<String, dynamic>)));
    } else {
      return null;
    }
  }

  //-----------------------------------

  // Null butsaadaggui parseruud
  //-----------------------------------
  static bool parseBool([Object? object]) {
    if (object is bool) return object;

    if (object is int) return object == 1;

    if (object is String) return object.toLowerCase() == 'true';

    return false;
  }

  static String parseString([Object? object]) {
    return object?.toString().trim() ?? "";
  }

  static double parseDouble([Object? object]) {
    if (object == null) return 0.0;

    double? val =
        double.tryParse(object.toString().replaceAll(RegExp(r"[,']"), ""));

    return val ?? 0.0;
  }

  static int parseInt([Object? object]) {
    if (object == null) return 0;

    int? val = int.tryParse(object.toString().replaceAll(RegExp(r"[,']"), ""));

    return val ?? 0;
  }

  static FontWeight parseFontWeight([Object? object]) {
    if (object == null) return FontWeight.normal;

    final val = object.toString();

    switch (val) {
      case "100":
        return FontWeight.w100;
      case "200":
        return FontWeight.w200;
      case "300":
        return FontWeight.w300;
      case "400":
        return FontWeight.w400;
      case "500":
        return FontWeight.w500;
      case "600":
        return FontWeight.w600;
      case "700":
        return FontWeight.w700;
      case "800":
        return FontWeight.w800;
      case "900":
        return FontWeight.w900;
      default:
        return FontWeight.normal;
    }
  }

  static DateTime parseDateTime([Object? object]) {
    if (object == null) return DateTime(0);

    DateTime? val = DateTime.tryParse(object.toString().replaceAll(".", "-"));

    return val ?? DateTime(0);
  }

  /// Ehnii parametr n dynamic list bn
  /// 2doh paramter n hurvuulegch
  static List<T> parseList<T>(
      [dynamic map, T Function(Map<String, dynamic>?)? converter]) {
    if (map is List && converter != null) {
      return List<T>.from(map.map((x) => converter(x as Map<String, dynamic>)));
    } else {
      return <T>[];
    }
  }

  //-----------------------------------
  static T parseEnumarator<T extends Enum>(
    Object? object,
    List<T> enumValues,
    T defaultValue,
  ) {
    if (object == null) return defaultValue;

    return enumValues.singleWhere(
      (enumItem) =>
          enumaratorToString(enumItem).toLowerCase() ==
          object.toString().toLowerCase(),
      orElse: () => defaultValue,
    );
  }

  static String enumaratorToString<T extends Enum>(T object) {
    return object.name;
  }
}

/// Registriin dugaariig useg toogoor n salgaj avdag func
class RegNoUtils {
  static String getFirstLetter(String? text) {
    if (text == null || text.isEmpty) {
      return " ";
    }

    final letter = text.substring(0, 1);
    return _isNumber(letter) ? "" : letter;
  }

  static String getSecondLetter(String? text) {
    if (text == null || text.isEmpty || text.length < 2) {
      return " ";
    }

    final letter = text.substring(1, 2);

    return _isNumber(letter) ? "" : letter;
  }

  static String getNumber(String? text) {
    if (text == null || text.isEmpty || text.length < 3) {
      return "";
    }

    final letter = text.substring(2);

    return _isNumber(letter) ? letter : "";
  }

  static bool _isNumber(String text) {
    return int.tryParse(text) != null;
  }

  static String consolidate(
      String firstChar, String secondChar, String number) {
    return firstChar + secondChar + number;
  }
}
