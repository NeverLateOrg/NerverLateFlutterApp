import 'package:calendar_view/calendar_view.dart';
import 'package:never_late_api_refont/extensions/calendar_event_data_ext.dart';

import '../models/event.dart';

extension EventControllerExtension on EventController<Event> {
  int getIndex(String id) {
    final index = events.indexWhere((element) => element.event?.id == id);
    return index;
  }

  bool contains(String id) {
    return getIndex(id) >= 0;
  }

  CalendarEventData<Event>? getOne(String id) {
    final index = getIndex(id);
    if (index >= 0) {
      return events[index];
    }
    return null;
  }

  bool containsEvent(CalendarEventData<Event> event) {
    if (event.event == null) return false;
    return getIndex(event.event!.id) >= 0;
  }

  void addOrUpdate(CalendarEventData<Event> newEvent) {
    if (containsEvent(newEvent)) {
      final CalendarEventData<Event> currentCed = getOne(newEvent.event!.id)!;
      if (currentCed.hasChanged(newEvent)) {
        remove(currentCed);
        add(newEvent);
      }
    } else {
      add(newEvent);
    }
  }

  void addOrUpdateAll(List<CalendarEventData<Event>> newEvents,
      {bool deleteIfNotIncluded = false}) {
    List<CalendarEventData<Event>> toAdd = [];
    List<CalendarEventData<Event>> toRemove = [];
    List<CalendarEventData<Event>> toRemoveIfDelete = List.from(events);
    if (events.isEmpty) {
      addAll(newEvents);
      return;
    }
    for (var newEvent in newEvents) {
      if (deleteIfNotIncluded) {
        toRemoveIfDelete
            .removeWhere((element) => element.event!.id == newEvent.event!.id);
      }
      if (containsEvent(newEvent)) {
        final CalendarEventData<Event> currentCed = getOne(newEvent.event!.id)!;
        if (currentCed.hasChanged(newEvent)) {
          toRemove.add(currentCed);
          toAdd.add(newEvent);
        }
      } else {
        toAdd.add(newEvent);
      }
    }
    print(
        "toRemove: ${toRemove.length}, toAdd: ${toAdd.length}, toRemoveIfDelete: ${toRemoveIfDelete.length}");
    if (deleteIfNotIncluded) {
      for (var event in toRemoveIfDelete) {
        remove(event);
      }
    }
    for (var event in toRemove) {
      remove(event);
    }
    addAll(toAdd);
  }
}
