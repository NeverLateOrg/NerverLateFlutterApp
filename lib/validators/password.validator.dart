import 'package:never_late_api_refont/validators/validator.dart';

class PasswordValidator extends Validator<String> {
  PasswordValidator(super.value);

  @override
  bool isValid() {
    if (value.isEmpty || value.length < 8) {
      return false;
    }
    return true;
  }
}
