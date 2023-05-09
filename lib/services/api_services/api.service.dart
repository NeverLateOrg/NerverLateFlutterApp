import 'package:never_late_api_refont/services/connection_service/connection.service.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:3000';

  String? get accessToken {
    ConnectionService connectionService = ConnectionService();
    return connectionService.getAccessToken();
  }
}
