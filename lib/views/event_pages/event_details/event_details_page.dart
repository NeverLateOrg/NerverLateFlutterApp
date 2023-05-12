import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../models/event.dart';
import 'event_details_body.dart';

enum PopupMenuChoice { edit, delete }

class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({Key? key, required this.event}) : super(key: key);

  final CalendarEventData<Event> event;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.tertiary,
        title: const Text('Event Details'),
        leading: IconButton(
          onPressed: navigatorKey.currentState!.pop,
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        actions: [
          PopupMenuButton<PopupMenuChoice>(
              color: Theme.of(context).colorScheme.primary,
              itemBuilder: (context) => [
                    const PopupMenuItem(
                        value: PopupMenuChoice.edit, child: Text('Edit')),
                    const PopupMenuItem(
                        value: PopupMenuChoice.delete, child: Text('Delete')),
                  ],
              onSelected: (value) {
                switch (value) {
                  case PopupMenuChoice.edit:
                    print('Edit');
                    break;
                  case PopupMenuChoice.delete:
                    print('Delete');
                    break;
                }
              })
        ],
      ),
      body: EventDetailsBody(event: event),
    );
  }
}
