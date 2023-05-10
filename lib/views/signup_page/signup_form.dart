import 'package:flutter/material.dart';

import '../../services/api_services/auth.service.dart';
import '../../services/connection_service/connection.service.dart';
import '../../utils/ui/popup_utils.dart';
import '../../validators/email.validator.dart';
import '../../validators/password.validator.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final GlobalKey<FormState> _form = GlobalKey();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  String _firstName = "";
  String _lastName = "";
  String _email = "";

  @override
  void initState() {
    super.initState();

    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _signup() async {
    if (!(_form.currentState?.validate() ?? true)) return;
    _form.currentState?.save();

    try {
      String accessToken = await AuthService().register(
        _firstName,
        _lastName,
        _email,
        _passwordController.text,
      );
      await ConnectionService().login(accessToken);
    } catch (e) {
      showInvalidDialog(context, "Registration failed");
    }

    _resetForm();
  }

  void _resetForm() {
    _form.currentState?.reset();
    _firstNameController.text = "";
    _lastNameController.text = "";
    _emailController.text = "";
    _passwordController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _firstNameController,
            decoration: const InputDecoration(
              labelText: "First Name",
            ),
            onSaved: (newValue) => _firstName = newValue?.trim() ?? "",
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _lastNameController,
            decoration: const InputDecoration(
              labelText: "Last Name",
            ),
            onSaved: (newValue) => _lastName = newValue?.trim() ?? "",
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: "Email",
            ),
            validator: (value) =>
                EmailValidator(value).isValid() ? null : "Invalid email.",
            onSaved: (newValue) => _email = newValue!,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              labelText: "Password",
            ),
            textInputAction: TextInputAction.next,
            validator: (value) =>
                PasswordValidator(value).isValid() ? null : "Invalid password.",
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _signup(),
              child: const Text('Signup'),
            ),
          ),
        ],
      ),
    );
  }
}
