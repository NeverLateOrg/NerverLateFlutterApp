import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:never_late_api_refont/models/event.dart';
import 'package:never_late_api_refont/services/api_services/api.service.dart';
import 'package:never_late_api_refont/services/api_services/utils/httpError.dart';

class EventsApiService extends ApiService {
  EventsApiService._privateConstructor();

  static final EventsApiService _instance =
      EventsApiService._privateConstructor();

  factory EventsApiService() {
    return _instance;
  }

  static String url = '${ApiService.baseUrl}/events';

  Future<List<Event>> getEvents() async {
    final res = await http.get(Uri.parse(EventsApiService.url),
        headers: Map.from({'Authorization': 'Bearer $accessToken'}));
    await handleInvalidCredentials(res);

    if (res.statusCode == 200) {
      List<dynamic> events = jsonDecode(res.body);
      List<Event> eventsFormatted =
          events.map((e) => Event.fromJson(e)).toList();
      return eventsFormatted;
    } else {
      final error = HttpError(res);
      if (error.statusCode == 400) {
        throw Exception("Bad request");
      } else if (error.statusCode == 401) {
        throw Exception("Invalid credentials");
      } else {
        throw Exception("An error occurred while logging in");
      }
    }
  }

  Future<Event> getEvent(String id) async {
    final url = '${EventsApiService.url}/$id';
    final res = await http.get(Uri.parse(url),
        headers: Map.from({'Authorization': 'Bearer $accessToken'}));
    await handleInvalidCredentials(res);

    if (res.statusCode == 200) {
      dynamic event = jsonDecode(res.body);
      return Event.fromJson(event);
    } else {
      final error = HttpError(res);
      if (error.statusCode == 400) {
        throw Exception("Bad request");
      } else if (error.statusCode == 401) {
        throw Exception("Invalid credentials");
      } else if (error.statusCode == 404) {
        throw Exception("Not Found");
      } else {
        throw Exception("An error occurred while logging in");
      }
    }
  }

  Future<void> deleteEvent(String id) async {
    final url = '${EventsApiService.url}/$id';
    final res = await http.delete(Uri.parse(url),
        headers: Map.from({'Authorization': 'Bearer $accessToken'}));
    await handleInvalidCredentials(res);

    if (res.statusCode == 204) {
      return;
    } else {
      final error = HttpError(res);
      if (error.statusCode == 401) {
        throw Exception("Invalid credentials");
      } else if (error.statusCode == 404) {
        throw Exception("Not Found");
      } else {
        throw Exception("An error occurred while logging in");
      }
    }
  }
}
