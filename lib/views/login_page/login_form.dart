import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:never_late_api_refont/validators/email.validator.dart';
import 'package:never_late_api_refont/validators/password.validator.dart';

import '../../services/api_services/auth.service.dart';
import '../../services/connection_service/connection.service.dart';
import '../../utils/ui/popup_utils.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _form = GlobalKey();

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  String _email = "";

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  Future<void> _login() async {
    if (!(_form.currentState?.validate() ?? true)) return;

    _form.currentState?.save();

    final String password = _passwordController.text;
    final String email = _email;

    try {
      String accessToken = await AuthService().login(
        email,
        password,
      );
      await ConnectionService().login(accessToken);
    } catch (e) {
      showInvalidDialog(context, "Login failed");
    }

    _resetForm();
  }

  void _resetForm() {
    _form.currentState?.reset();
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
            controller: _emailController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person_outline_outlined),
              labelText: "Email",
            ),
            validator: (value) =>
                EmailValidator(value).isValid() ? null : "Invalid email.",
            onSaved: (newValue) => _email = newValue!,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.fingerprint),
              labelText: "Password",
              suffixIcon: IconButton(
                onPressed: () {
                  // TODO: Change the obscureText property
                },
                icon: const Icon(
                  Icons.remove_red_eye_sharp,
                ),
              ),
            ),
            textInputAction: TextInputAction.next,
            validator: (value) =>
                PasswordValidator(value).isValid() ? null : "Invalid password.",
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: RichText(
              text: TextSpan(
                text: "Forgot password?",
                style: const TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // TODO: Password recovery
                  },
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _login(),
              child: const Text("Login"),
            ),
          ),
        ],
      ),
    );
  }
}
