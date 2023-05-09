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
}
