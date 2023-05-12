import 'package:calendar_view/calendar_view.dart';
import 'package:never_late_api_refont/models/travel.dart';

class Event {
  Event({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    this.location,
    this.travels = const [],
  });

  String id;
  String title;
  DateTime startDate;
  DateTime endDate;
  String? location;
  List<Travel> travels;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["_id"],
        title: json["title"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        location: json["location"],
        travels: (json["travels"] as List<dynamic>)
            .map((e) => Travel.make(json["_id"], e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {};

  CalendarEventData<Event> toCalendarEventData() {
    return CalendarEventData<Event>(
      event: this,
      title: title,
      date: startDate,
      startTime: startDate,
      endDate: endDate,
      endTime: endDate,
    );
  }
}
