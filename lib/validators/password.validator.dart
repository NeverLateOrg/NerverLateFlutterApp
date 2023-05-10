import 'package:never_late_api_refont/validators/validator.dart';

class PasswordValidator extends Validator<String?> {
  PasswordValidator(super.value);

  @override
  bool isValid() {
    if (value == null) {
      return false;
    }
    String v = value as String;
    if (v.isEmpty || v.length < 8) {
      return false;
    }
    return true;
  }
}
