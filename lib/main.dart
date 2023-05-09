import 'package:flutter/material.dart';
import 'package:never_late_api_refont/services/connection_service/connection.service.dart';
import 'package:never_late_api_refont/theme/theme_constant.dart';
import 'package:never_late_api_refont/views/home_page.dart';
import 'package:never_late_api_refont/views/login_page.dart';

void main() {
  runApp(const Material(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: mainTheme,
      home: FutureBuilder(
        future: ConnectionService().isLogged(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          print(Theme.of(context).colorScheme.primary);

          if (snapshot.data == true) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
