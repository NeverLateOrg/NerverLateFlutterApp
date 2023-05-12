import 'package:http/http.dart';
import 'package:never_late_api_refont/services/api_services/utils/httpError.dart';
import 'package:never_late_api_refont/services/connection_service/connection.service.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:3000';

  String? get accessToken {
    ConnectionService connectionService = ConnectionService();
    return connectionService.getAccessToken();
  }

  handleInvalidCredentials(Response response) async {
    if (response.statusCode == 401) {
      final error = HttpError(response);
      if (error.type == 'ExpiredOrInvalidToken') {
        ConnectionService connectionService = ConnectionService();
        await connectionService.logout();
      }
    }
  }
}
