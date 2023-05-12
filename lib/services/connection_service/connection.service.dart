import 'package:flutter/material.dart';
import 'package:never_late_api_refont/services/manager_services.dart';
import 'package:never_late_api_refont/views/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../views/login_page/login_page.dart';

class ConnectionService {
  ConnectionService._privateConstructor();

  static final ConnectionService _instance =
      ConnectionService._privateConstructor();

  factory ConnectionService() {
    return _instance;
  }

  bool? isConnected;
  String? accessToken;

  Future<void> login(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', accessToken);
    this.accessToken = accessToken;
    isConnected = true;
    navigatorKey.currentState!.pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()));
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('access_token');
    accessToken = null;
    isConnected = false;
    ManagerServices().resetAll();
    navigatorKey.currentState!.pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  Future<bool> isLogged() async {
    if (isConnected == null) {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('access_token')) {
        return false;
      }
      accessToken = prefs.getString('access_token');
      return true;
    }
    return isConnected ?? false;
  }

  Future<bool> isLogout() async {
    return !(await isLogged());
  }

  String? getAccessToken() {
    return accessToken;
  }
}
