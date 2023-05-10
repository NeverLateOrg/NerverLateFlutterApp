import 'package:never_late_api_refont/validators/validator.dart';

class EmailValidator extends Validator<String?> {
  EmailValidator(super.value);

  @override
  bool isValid() {
    if (value == null) {
      return false;
    }
    String v = value as String;
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegExp.hasMatch(v) ? true : false;
  }
}
