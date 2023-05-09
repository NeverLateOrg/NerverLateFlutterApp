import 'package:never_late_api_refont/models/customLocation.dart';
import 'package:never_late_api_refont/models/placeLocation.dart';

class LocationService {
  LocationService._privateConstructor();

  static final LocationService _instance =
      LocationService._privateConstructor();

  factory LocationService() {
    return _instance;
  }

  final List<PlaceLocation> _placeLocations = [
    PlaceLocation(
        id: '6456d13104ce784e8997968d',
        name: 'Eiffel Tower From the secondary iyyama',
        address: '42 rue du pilon, France 75000'),
    PlaceLocation(
        id: '6456d13104ce784e8997968d',
        name: 'Eiffel Tower 2',
        address: '42 rue du pilon, France 75000'),
    PlaceLocation(
        id: '6456d13104ce784e8997968d',
        name: 'Eiffel Tower 3',
        address: '42 rue du pilon, France 75000')
  ];
  List<PlaceLocation> get placeLocations => _placeLocations;

  final List<CustomLocation> _customLocations = [
    CustomLocation(
        id: '6456d13104ce784e8997968d',
        name: 'My custom location',
        location: '12.2423,1.2342'),
  ];
  List<CustomLocation> get customLocations => _customLocations;
}
