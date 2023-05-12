import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:never_late_api_refont/models/event.dart';

class CalendarMonthView extends StatefulWidget {
  const CalendarMonthView({Key? key}) : super(key: key);

  @override
  _CalendarMonthViewState createState() => _CalendarMonthViewState();
}

class _CalendarMonthViewState extends State<CalendarMonthView> {
  @override
  Widget build(BuildContext context) {
    return MonthView<Event>(
      onEventTap: (event, date) {
        print('Tapped event: $event');
      },
    );
  }
}
