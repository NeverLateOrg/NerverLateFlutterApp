import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:never_late_api_refont/models/google_location.dart';
import 'package:never_late_api_refont/services/api_services/utils/httpError.dart';

import 'api.service.dart';

class GoogleApiService extends ApiService {
  GoogleApiService._privateConstructor();

  static final GoogleApiService _instance =
      GoogleApiService._privateConstructor();

  factory GoogleApiService() {
    return _instance;
  }

  static String url = '${ApiService.baseUrl}/google';

  Future<GoogleLocationsResponse> getPlaceByText(String input) async {
    final encodedInput = Uri.encodeQueryComponent(input);

    final res = await http.get(
        Uri.parse('${GoogleApiService.url}/place?input=$encodedInput'),
        headers: Map.from({'Authorization': 'Bearer $accessToken'}));
    await handleInvalidCredentials(res);

    if (res.statusCode == 200) {
      dynamic response = jsonDecode(res.body);
      return GoogleLocationsResponse.fromJson(response);
    } else {
      final error = HttpError(res);
      if (error.statusCode == 400) {
        throw Exception("Bad request");
      } else if (error.statusCode == 401) {
        throw Exception("Invalid credentials");
      } else {
        print(error.body);
        throw Exception("An error occurred while logging in");
      }
    }
  }

  Future<GoogleLocationsResponse> getNextPage(
      GoogleLocationsResponse glr) async {
    if (!glr.hasMore()) {
      return GoogleLocationsResponse(places: []);
    }
    final res = await http.get(
        Uri.parse(
            "${GoogleApiService.url}/place/next?nextPageToken=${glr.nextPageToken}"),
        headers: Map.from({'Authorization': 'Bearer $accessToken'}));
    await handleInvalidCredentials(res);

    if (res.statusCode == 200) {
      dynamic response = jsonDecode(res.body);
      return GoogleLocationsResponse.fromJson(response);
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
}
