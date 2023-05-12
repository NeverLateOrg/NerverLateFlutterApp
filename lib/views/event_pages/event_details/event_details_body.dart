import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:never_late_api_refont/extensions/calendar_event_data_ext.dart';
import 'package:never_late_api_refont/models/event.dart';
import 'package:never_late_api_refont/views/event_pages/event_details/widgets/event_travels_view.dart';

import '../../../extensions/date_time_extensions.dart';

class EventDetailsBody extends StatelessWidget {
  const EventDetailsBody({Key? key, required this.event}) : super(key: key);

  final CalendarEventData<Event> event;

  @override
  Widget build(BuildContext context) {
    Event eventData = event.getEvent();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Text(
            event.title,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            'Starts ${eventData.startDate.dateToStringWithFormat(format: "MMMM d")} at ${eventData.startDate.getTimeInFormat(TimeStampFormat.parse_24)}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Text(
            'Ends ${eventData.endDate.dateToStringWithFormat(format: "MMMM d")} at ${eventData.endDate.getTimeInFormat(TimeStampFormat.parse_24)}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            "Location",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          //TODO: change Text to clickable custom widget
          child: Text(
            event.event?.location ?? 'No location',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            "Travels",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: EventTravelsView(event: event)),
      ],
    );
  }
}
