import 'package:flutter/material.dart';

Future<void> showInvalidDialog(
    BuildContext context, String errorMessage) async {
  await showDialog<bool>(
    context: context,
    builder: (context) => WillPopScope(
      child: AlertDialog(
        content: Text(errorMessage),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        actionsAlignment: MainAxisAlignment.center,
      ),
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
    ),
  );
}
