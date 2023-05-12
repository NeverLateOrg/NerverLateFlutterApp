import 'package:calendar_view/calendar_view.dart';

import '../models/event.dart';

extension CalendarEventDataExtension on CalendarEventData<Event> {
  bool hasChanged(CalendarEventData<Event> newCed) {
    if (event!.id != newCed.event!.id) {
      throw Exception('Cannot check changes between two different events');
    }
    final Event currentEvent = event!;
    final Event newEvent = newCed.event!;
    return currentEvent.title != newEvent.title ||
        currentEvent.startDate != newEvent.startDate ||
        currentEvent.endDate != newEvent.endDate ||
        currentEvent.location != newEvent.location;
  }

  Event getEvent() {
    return event!;
  }
}
