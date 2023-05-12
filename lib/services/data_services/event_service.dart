import 'package:calendar_view/calendar_view.dart';
import 'package:never_late_api_refont/extensions/event_controller_ext.dart';
import 'package:never_late_api_refont/models/event.dart';
import 'package:never_late_api_refont/services/api_services/events_api_service.dart';
import 'package:never_late_api_refont/services/data_services/list_data_service.dart';

class EventService implements ListDataService<CalendarEventData<Event>> {
  EventService._privateConstructor();

  static final EventService _instance = EventService._privateConstructor();

  factory EventService() {
    return _instance;
  }

  final EventController<Event> _controller = EventController<Event>();
  EventController<Event> get controller => _controller;

  final EventsApiService _apiService = EventsApiService();

  @override
  List<CalendarEventData<Event>> getAll() {
    return _controller.events;
  }

  @override
  CalendarEventData<Event>? getOne(String id) {
    final index = getIndex(id);
    if (index >= 0) {
      return _controller.events[index];
    }
    return null;
  }

  @override
  Future<void> syncRemoteAll() async {
    final events = await _apiService.getEvents();
    _controller.addOrUpdateAll(
        events.map((e) => e.toCalendarEventData()).toList(),
        deleteIfNotIncluded: true);
  }

  @override
  Future<void> syncRemoteOne(String id) async {
    final event = await _apiService.getEvent(id);
    _controller.addOrUpdate(event.toCalendarEventData());
  }

  @override
  int getIndex(String id) {
    return _controller.getIndex(id);
  }

  @override
  void reset() {
    _controller.removeWhere((element) => true);
  }
}
