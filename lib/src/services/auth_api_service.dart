
import 'package:flutter_meetuper/src/models/forms.dart';
import 'package:flutter_meetuper/src/models/meetup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' show Platform;


class AuthApiService {
  final String url = Platform.isIOS ? 'http://localhost:3001/api/v1' : 'http://10.0.2.2:3001/api/v1';
  String _token;

  static final AuthApiService _singleton = AuthApiService._internal();

  factory AuthApiService() {
    return _singleton;
  }
  AuthApiService._internal();

  bool _saveToken(String token) {
    if (token != null) {
      _token = token;
      return true;
    }

    return false;
  }

  Future<Map<String, dynamic>> login(LoginFormData loginData) async {
    final body = json.encode(loginData.toJSON());
    print(body);
    final res = await http.post('$url/users/login',
                                 headers: {"Content-Type": "application/json"},
                                 body: body);
    final parsedData = Map<String, dynamic>.from(json.decode(res.body));

    if (res.statusCode == 200) {
      _saveToken(parsedData['token']);
      print(_token);
      return parsedData;
    } else {
      return Future.error(parsedData);
    }
  }

}
