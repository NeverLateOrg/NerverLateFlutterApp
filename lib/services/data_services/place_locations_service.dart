import 'package:never_late_api_refont/services/data_services/list_data_service.dart';

import '../../models/placeLocation.dart';
import '../api_services/place_locations_api_service.dart';

class PlaceLocationsService implements ListDataService<PlaceLocation> {
  PlaceLocationsService._privateConstructor();

  static final PlaceLocationsService _instance =
      PlaceLocationsService._privateConstructor();

  factory PlaceLocationsService() {
    return _instance;
  }

  final PlaceLocationsApiService _apiService = PlaceLocationsApiService();

  List<PlaceLocation> _placeLocations = [];
  List<PlaceLocation> get placeLocations => _placeLocations;

  @override
  List<PlaceLocation> getAll() {
    return _placeLocations;
  }

  @override
  PlaceLocation? getOne(String id) {
    final index = getIndex(id);
    if (index >= 0) {
      return _placeLocations[index];
    }
    return null;
  }

  @override
  Future<void> syncRemoteAll() async {
    final locations = await _apiService.getPlaceLocations();
    _placeLocations = locations;
  }

  @override
  Future<void> syncRemoteOne(String id) async {
    final location = await _apiService.getPlaceLocation(id);
    final index = getIndex(id);
    if (index >= 0) {
      _placeLocations[index] = location;
    } else {
      _placeLocations.add(location);
    }
  }

  @override
  int getIndex(String id) {
    final index = _placeLocations.indexWhere((element) => element.id == id);
    return index;
  }

  @override
  void reset() {
    _placeLocations = [];
  }
}
