import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:never_late_api_refont/models/placeLocation.dart';
import 'package:never_late_api_refont/services/api_services/api.service.dart';

import 'httpError.dart';

class PlaceLocationsApiService extends ApiService {
  PlaceLocationsApiService._privateConstructor();

  static final PlaceLocationsApiService _instance =
      PlaceLocationsApiService._privateConstructor();

  factory PlaceLocationsApiService() {
    return _instance;
  }

  static String authUrl = '${ApiService.baseUrl}/locations/place';

  String getPlaceLocationsImageUrl(String placeLocationId) {
    return '$authUrl/$placeLocationId/photo';
  }

  Future<List<PlaceLocation>> getPlaceLocations() async {
    final res = await http.get(Uri.parse(PlaceLocationsApiService.authUrl),
        headers: Map.from({'Authorization': 'Bearer $accessToken'}));
    await handleInvalidCredentials(res);

    if (res.statusCode == 200) {
      List<dynamic> places = jsonDecode(res.body);
      List<PlaceLocation> placeLocations =
          places.map((e) => PlaceLocation.fromJson(e)).toList();
      return placeLocations;
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

  Future<PlaceLocation> getPlaceLocation(String id) async {
    final url = '${PlaceLocationsApiService.authUrl}/$id';
    final res = await http.get(Uri.parse(url),
        headers: Map.from({'Authorization': 'Bearer $accessToken'}));
    await handleInvalidCredentials(res);

    if (res.statusCode == 200) {
      dynamic placeLocation = jsonDecode(res.body);
      return PlaceLocation.fromJson(placeLocation);
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
}
