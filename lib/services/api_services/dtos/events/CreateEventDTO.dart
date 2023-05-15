import 'package:never_late_api_refont/services/api_services/dtos/Dto.dart';

class CreateEventDTO implements Dto {
  CreateEventDTO({
    required this.title,
    required this.startDate,
    required this.endDate,
    this.location,
  });

  String title;
  DateTime startDate;
  DateTime endDate;
  String? location;

  @override
  bool isValid() {
    if (startDate.isAfter(endDate)) {
      return false;
    }
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {
        "title": title,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "location": location ?? "",
      };
}
