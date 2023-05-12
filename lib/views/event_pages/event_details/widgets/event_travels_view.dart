import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:never_late_api_refont/extensions/calendar_event_data_ext.dart';
import 'package:never_late_api_refont/models/event.dart';
import 'package:never_late_api_refont/models/travel.dart';

import 'event_travel_item.dart';

class EventTravelsView extends StatelessWidget {
  final CalendarEventData<Event> event;

  const EventTravelsView({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    List<Travel> travels = event.getEvent().travels;

    print(travels);
    if (travels.isEmpty) {
      return const Text("No travels from previous events");
    }
    print('items nb: ${travels.length}');
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 10),
        itemCount: travels.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: EventTravelItem(travel: travels[index]));
        });
  }
}
