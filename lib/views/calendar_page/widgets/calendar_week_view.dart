import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:never_late_api_refont/models/event.dart';

class CalendarWeekView extends StatefulWidget {
  const CalendarWeekView({Key? key, required this.militaryHourFormat})
      : super(key: key);

  /// If the hour should be showed in 24-hour format
  final bool militaryHourFormat;

  @override
  _CalendarWeekViewState createState() => _CalendarWeekViewState();
}

class _CalendarWeekViewState extends State<CalendarWeekView> {
  @override
  Widget build(BuildContext context) {
    return WeekView<Event>(
      weekNumberBuilder: (firstDayOfWeek) => null,
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
        print('Tapped event: $events');
      },
    );
  }
}
