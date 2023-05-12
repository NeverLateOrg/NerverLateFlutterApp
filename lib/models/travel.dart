import 'package:calendar_view/calendar_view.dart';
import 'package:never_late_api_refont/services/data_services/event_service.dart';

import 'event.dart';

class Travel {
  Travel({
    required this.fromEventId,
    required this.toEventId,
    required this.duration,
    required this.departureDate,
  });

  final String fromEventId;
  final String toEventId;

  final int duration;
  final DateTime departureDate;

  CalendarEventData<Event> get fromEvent => EventService().getOne(fromEventId)!;
  CalendarEventData<Event> get toEvent => EventService().getOne(toEventId)!;

  factory Travel.make(String toEventId, Map<String, dynamic> json) {
    return Travel(
      toEventId: toEventId,
      fromEventId: json['fromEvent'],
      duration: json['duration'],
      departureDate: DateTime.parse(json['departureDate']),
    );
  }
}
