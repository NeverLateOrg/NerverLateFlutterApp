import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:never_late_api_refont/models/customLocation.dart';
import 'package:never_late_api_refont/services/api_services/api.service.dart';

import 'httpError.dart';

class CustomLocationsApiService extends ApiService {
  CustomLocationsApiService._privateConstructor();

  static final CustomLocationsApiService _instance =
      CustomLocationsApiService._privateConstructor();

  factory CustomLocationsApiService() {
    return _instance;
  }

  static String url = '${ApiService.baseUrl}/locations/custom';

  Future<List<CustomLocation>> getCustomLocations() async {
    final res = await http.get(Uri.parse(CustomLocationsApiService.url),
        headers: Map.from({'Authorization': 'Bearer $accessToken'}));
    await handleInvalidCredentials(res);

    if (res.statusCode == 200) {
      List<dynamic> places = jsonDecode(res.body);
      List<CustomLocation> customLocations =
          places.map((e) => CustomLocation.fromJson(e)).toList();
      return customLocations;
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

  Future<CustomLocation> getCustomLocation(String id) async {
    final url = '${CustomLocationsApiService.url}/$id';
    final res = await http.get(Uri.parse(url),
        headers: Map.from({'Authorization': 'Bearer $accessToken'}));
    await handleInvalidCredentials(res);

    if (res.statusCode == 200) {
      dynamic customLocation = jsonDecode(res.body);
      return CustomLocation.fromJson(customLocation);
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
