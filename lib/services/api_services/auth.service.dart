import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:never_late_api_refont/services/api_services/api.service.dart';

class AuthService extends ApiService {
  AuthService._privateConstructor();

  static final AuthService _instance = AuthService._privateConstructor();

  factory AuthService() {
    return _instance;
  }

  static String authUrl = '${ApiService.baseUrl}/auth';

  Future<String> login(String email, String password) async {
    final body = {
      "email": email,
      "password": password,
    };
    final String url = '${AuthService.authUrl}/login';

    final res = await http.post(Uri.parse(url), body: body);

    if (res.statusCode == 200) {
      final Map<String, dynamic> result = jsonDecode(res.body);
      return result['access_token'];
    } else if (res.statusCode == 400) {
      throw Exception("Bad request");
    } else if (res.statusCode == 401) {
      throw Exception("Invalid credentials");
    } else {
      throw Exception("An error occurred while logging in");
    }
  }
}
