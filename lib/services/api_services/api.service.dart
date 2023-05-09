import 'package:never_late_api_refont/services/connection_service/connection.service.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:3000';

  Future<String?> get accessToken async {
    ConnectionService connectionService = ConnectionService();
    return await connectionService.getAccessToken();
  }
}
