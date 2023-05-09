// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:never_late_api_refont/services/api_services/auth.service.dart';
import 'package:never_late_api_refont/services/connection_service/connection.service.dart';
import 'package:never_late_api_refont/validators/email.validator.dart';
import 'package:never_late_api_refont/validators/password.validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final String password = _passwordController.text;
    final String email = _emailController.text;
    // Checkers
    bool isPasswordValid = PasswordValidator(password).isValid();
    bool isEmailValid = EmailValidator(email).isValid();

    if (!isPasswordValid) {
      throw Exception("Password is not valid");
    }
    if (!isEmailValid) {
      throw Exception("Email is not valid");
    }

    String accessToken = await AuthService().login(
      _emailController.text,
      _passwordController.text,
    );
    await ConnectionService().login(accessToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  hintText: 'Password', errorText: 'Password is not valid'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _login();
                } catch (e) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Login failed'),
                      content: Text(e.toString()),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Text('Log In'),
            ),
          ],
        ),
      ),
    );
  }
}
