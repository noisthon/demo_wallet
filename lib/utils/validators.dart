abstract interface class CustomValidators {
  static bool isNotEmpty(dynamic obj) {
    final value = obj.toString();
    return value.isNotEmpty;
  }

  static bool maxLength(dynamic obj, int maxLength) {
    final value = obj.toString();
    return value.length <= maxLength;
  }
  static bool length(dynamic obj, int length) {
    final value = obj.toString();
    return value.length == length;
  }

  static bool minLength(dynamic obj, int minLength) {
    final value = obj.toString();
    return value.length >= minLength;
  }

  static bool isPhone(dynamic obj) {
    final value = obj.toString();

    final RegExp regExp = RegExp(r'^[6-9]{1}\d{7}$');

    return regExp.hasMatch(value);
  }
  static bool isNumeric(dynamic obj) {
    final value = obj.toString();

    final RegExp regExp = RegExp(r'^\d+$');

    return regExp.hasMatch(value);
  }

  static bool isEmail(dynamic obj) {
    final value = obj.toString();

    final RegExp regExp = RegExp(
        r"""^(?:[a-zA-Z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-zA-Z0-9!#$%&'*+\/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])$""");

    return regExp.hasMatch(value);
  }
}
