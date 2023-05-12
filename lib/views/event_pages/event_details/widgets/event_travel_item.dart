import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../../../models/event.dart';
import '../../../../models/travel.dart';
import '../../../../utils/duration_utils.dart';
import '../event_details_page.dart';

class EventTravelItem extends StatelessWidget {
  final Travel travel;

  const EventTravelItem({
    super.key,
    required this.travel,
  });

  @override
  Widget build(BuildContext context) {
    CalendarEventData<Event> fromEvent = travel.fromEvent;

    return InkWell(
        child: Container(
          height: 50,
          padding: const EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(5)),
          child: Text(
              '${formatDuration(travel.duration)}s from ${fromEvent.title}'),
        ),
        onTap: () {
          navigatorKey.currentState!.push(MaterialPageRoute(
              builder: (context) => EventDetailsPage(event: fromEvent)));
        });
  }
}
