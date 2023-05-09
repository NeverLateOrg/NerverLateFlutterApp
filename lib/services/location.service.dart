import 'package:never_late_api_refont/models/customLocation.dart';
import 'package:never_late_api_refont/models/placeLocation.dart';
import 'package:never_late_api_refont/services/api_services/place.locations.service.dart';

class LocationService {
  LocationService._privateConstructor();

  static final LocationService _instance =
      LocationService._privateConstructor();

  factory LocationService() {
    return _instance;
  }

  Future<void> updatePlaces() async {
    List<PlaceLocation> placeLocation =
        await PlaceLocationsService().getPlaceLocations();
    List<CustomLocation> customLocation = [];
    _placeLocations = placeLocation;
    _customLocations = customLocation;
  }

  List<PlaceLocation> _placeLocations = [];
  List<PlaceLocation> get placeLocations => _placeLocations;

  List<CustomLocation> _customLocations = [];
  List<CustomLocation> get customLocations => _customLocations;
}
