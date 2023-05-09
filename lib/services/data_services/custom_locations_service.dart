import 'package:never_late_api_refont/models/customLocation.dart';
import 'package:never_late_api_refont/services/api_services/custom_locations_api_service.dart';
import 'package:never_late_api_refont/services/data_services/list_data_service.dart';

class CustomLocationsService implements ListDataService<CustomLocation> {
  CustomLocationsService._privateConstructor();

  static final CustomLocationsService _instance =
      CustomLocationsService._privateConstructor();

  factory CustomLocationsService() {
    return _instance;
  }

  final CustomLocationsApiService _apiService = CustomLocationsApiService();

  List<CustomLocation> _customLocations = [];
  List<CustomLocation> get customLocations => _customLocations;

  @override
  List<CustomLocation> getAll() {
    return _customLocations;
  }

  @override
  CustomLocation? getOne(String id) {
    final index = getIndex(id);
    if (index >= 0) {
      return _customLocations[index];
    }
    return null;
  }

  @override
  Future<void> updateRemoteAll() async {
    final locations = await _apiService.getCustomLocations();
    _customLocations = locations;
  }

  @override
  Future<void> updateRemoteOne(String id) async {
    final location = await _apiService.getCustomLocation(id);
    final index = getIndex(id);
    if (index >= 0) {
      _customLocations[index] = location;
    } else {
      _customLocations.add(location);
    }
  }

  @override
  int getIndex(String id) {
    final index = _customLocations.indexWhere((element) => element.id == id);
    return index;
  }
}
