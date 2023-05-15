import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:never_late_api_refont/models/event.dart';
import 'package:never_late_api_refont/views/event_pages/event_details/event_details_page.dart';

import '../../../main.dart';

class CalendarDayView extends StatefulWidget {
  const CalendarDayView({Key? key, required this.militaryHourFormat})
      : super(key: key);

  /// If the hour should be showed in 24-hour format
  final bool militaryHourFormat;

  @override
  _CalendarDayViewState createState() => _CalendarDayViewState();
}

class _CalendarDayViewState extends State<CalendarDayView> {
  @override
  Widget build(BuildContext context) {
    return DayView<Event>(
      timeLineBuilder: (date) => widget.militaryHourFormat
          ? DefaultTimeLineMark(
              date: date,
              timeStringBuilder: (date, {secondaryDate}) =>
                  "${date.hour < 10 ? '0' : ''}${date.hour % 24}:00",
            )
          : DefaultTimeLineMark(
              date: date,
            ),
      onEventTap: (events, date) {
        navigatorKey.currentState!.push(MaterialPageRoute(
            builder: (context) => EventDetailsPage(event: events.first)));
      },
    );
  }
}
