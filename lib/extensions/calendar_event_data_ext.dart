import 'package:calendar_view/calendar_view.dart';
import 'package:never_late_api_refont/extensions/travel_list_ext.dart';
import 'package:never_late_api_refont/services/data_services/event_service.dart';

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
        currentEvent.location != newEvent.location ||
        currentEvent.travels.hasChanged(newEvent.travels);
  }

  CalendarEventData<Event> syncLocal() {
    return EventService().getOne(event!.id)!;
  }

  Event getEvent() {
    return event!;
  }
}
