import 'package:never_late_api_refont/services/data_services/event_service.dart';

import 'data_services/custom_locations_service.dart';
import 'data_services/place_locations_service.dart';

class ManagerServices {
  ManagerServices._privateConstructor();

  static final ManagerServices _instance =
      ManagerServices._privateConstructor();

  factory ManagerServices() {
    return _instance;
  }

  // reset all local data (for example, when user logout)
  void resetAll() {
    CustomLocationsService().reset();
    PlaceLocationsService().reset();
    EventService().reset();
  }
}
