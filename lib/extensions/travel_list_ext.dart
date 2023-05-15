import 'package:never_late_api_refont/models/travel.dart';

extension TravelListExtension on List<Travel> {
  bool hasChanged(List<Travel> newTravels) {
    if (length != newTravels.length) {
      return true;
    }

    final thisSet = Set.from(this);
    final newSet = Set.from(newTravels);

    return !thisSet.containsAll(newSet);
  }
}
