import 'package:flutter/material.dart';
import 'package:never_late_api_refont/views/event_pages/event_create/event_create_body.dart';

import '../../../main.dart';

class EventCreatePage extends StatelessWidget {
  const EventCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.tertiary,
        title: const Text('Create an Event'),
        leading: IconButton(
          onPressed: navigatorKey.currentState!.pop,
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: const EventCreateBody(),
    );
  }
}
