import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:never_late_api_refont/models/placeLocation.dart';
import 'package:never_late_api_refont/services/api_services/api.service.dart';

class PlaceLocationsService extends ApiService {
  PlaceLocationsService._privateConstructor();

  static final PlaceLocationsService _instance =
      PlaceLocationsService._privateConstructor();

  factory PlaceLocationsService() {
    return _instance;
  }

  static String authUrl = '${ApiService.baseUrl}/locations/place';

  String getPlaceLocationsImageUrl(String placeLocationId) {
    return '$authUrl/$placeLocationId/photo';
  }

  Future<List<PlaceLocation>> getPlaceLocations() async {
    final res = await http.get(Uri.parse(PlaceLocationsService.authUrl),
        headers: Map.from({'Authorization': 'Bearer $accessToken'}));

    if (res.statusCode == 200) {
      List<dynamic> places = jsonDecode(res.body);
      List<PlaceLocation> placeLocations =
          places.map((e) => PlaceLocation.fromJson(e)).toList();
      return placeLocations;
    } else if (res.statusCode == 400) {
      throw Exception("Bad request");
    } else if (res.statusCode == 401) {
      throw Exception("Invalid credentials");
    } else {
      throw Exception("An error occurred while logging in");
    }
  }
}
