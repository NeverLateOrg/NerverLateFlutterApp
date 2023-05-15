import 'package:flutter/material.dart';
import 'package:never_late_api_refont/main.dart';
import 'package:never_late_api_refont/services/connection_service/connection.service.dart';
import 'package:never_late_api_refont/views/setting_page/widgets/profile_menu_item.dart';

import '../../widgets/app_large_text.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          title: AppLargeText(
            text: 'Settings',
            color: Theme.of(context).colorScheme.primary,
          )),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              ProfileMenuItem(
                icon: Icons.logout,
                title: "Log out",
                onPressed: () async {
                  if (await _showConfirmLogoutDialogButton(context)) {
                    ConnectionService().logout();
                  }
                },
                endIcon: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _showConfirmLogoutDialogButton(BuildContext context) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => WillPopScope(
        child: AlertDialog(
          content: const Text('Are you sure to logout?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => navigatorKey.currentState!.pop(false),
            ),
            TextButton(
              child: const Text('Log out'),
              onPressed: () => navigatorKey.currentState!.pop(true),
            ),
          ],
        ),
        onWillPop: () async {
          navigatorKey.currentState!.pop(false);
          return true;
        },
      ),
    );
    return confirm ?? false;
  }
}
