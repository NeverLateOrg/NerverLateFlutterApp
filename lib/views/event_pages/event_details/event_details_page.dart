import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:never_late_api_refont/extensions/calendar_event_data_ext.dart';
import 'package:never_late_api_refont/services/data_services/event_service.dart';

import '../../../main.dart';
import '../../../models/event.dart';
import 'event_details_body.dart';

enum PopupMenuChoice { edit, delete }

class EventDetailsPage extends StatelessWidget {
  EventDetailsPage({Key? key, required this.event}) : super(key: key);

  CalendarEventData<Event> event;

  _load() async {
    await EventService().syncRemoteAll();
    event = event.syncLocal();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return FutureBuilder(
        future: _load(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
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
                                value: PopupMenuChoice.edit,
                                child: Text('Edit')),
                            const PopupMenuItem(
                                value: PopupMenuChoice.delete,
                                child: Text('Delete')),
                          ],
                      onSelected: (value) async {
                        switch (value) {
                          case PopupMenuChoice.edit:
                            print('Edit');
                            break;
                          case PopupMenuChoice.delete:
                            if (await _showConfirmDeleteDialogButton(context)) {
                              await EventService()
                                  .deleteEvent(event.getEvent().id);
                              navigatorKey.currentState!.pop();
                            }
                            break;
                        }
                      })
                ],
              ),
              body: EventDetailsBody(event: event),
            );
          }
        });
  }

  Future<bool> _showConfirmDeleteDialogButton(BuildContext context) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => WillPopScope(
        child: AlertDialog(
          content: const Text('Are you sure to delete this event?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => navigatorKey.currentState!.pop(false),
            ),
            TextButton(
                child: const Text('Delete'),
                onPressed: () => navigatorKey.currentState!.pop(true)),
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
