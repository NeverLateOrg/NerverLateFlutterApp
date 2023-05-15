import 'dart:convert';

import 'package:http/http.dart';

class HttpError {
  final Response _response;
  late int _statusCode;
  late Map<String, dynamic> _body;

  int get statusCode => _statusCode;
  Map<String, dynamic> get body => _body;

  late dynamic _error;
  late String? _type;

  dynamic get error => _error;
  String? get type => _type;

  HttpError(this._response) {
    _statusCode = _response.statusCode;
    _body = jsonDecode(_response.body);
    _error = _body['error'];
    if (_error is Map<String, dynamic>) {
      _type = _error['type'];
    }
  }
}
