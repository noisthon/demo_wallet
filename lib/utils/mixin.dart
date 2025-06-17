import 'package:wallet/utils/typedef.dart';
import 'package:wallet/utils/validators.dart';

mixin ValidationMixin {
  ValidationCallback mobileNoValidator() => (Object mobileNo) =>
      CustomValidators.isPhone(mobileNo) ? null : 'Invalid mobile phone';

  ValidationCallback requiredValidator() => (Object value) =>
      CustomValidators.isNotEmpty(value) ? null : 'Cannot be empty';

  ValidationCallback minLength(int minLength) =>
      (Object value) => CustomValidators.minLength(value, minLength)
          ? null
          : 'field must be at least $minLength characters.';

  ValidationCallback length(int length) =>
      (Object value) => CustomValidators.length(value, length)
          ? null
          : 'field length must be $length characters.';
  ValidationCallback maxLength(int maxLength) =>
      (Object value) => CustomValidators.maxLength(value, maxLength)
          ? null
          : 'field cannot be more than $maxLength characters.';
  ValidationCallback numeric() =>
      (Object value) => CustomValidators.isNumeric(value)
          ? null
          : 'Only numeric characters are allowed.';
}
