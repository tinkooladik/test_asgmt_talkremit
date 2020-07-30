import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/LoginRequest.dart';

class ApiService {
  static const String _API_ENDPOINT = "https://test-api.talkremit.com";

  static Future<bool> login(LoginRequest requestBody) async {
    print("login | body: ${requestBody.toString()}");

    await http
        .post("$_API_ENDPOINT/user/login",
            headers: {"Content-type": "application/json; charset=UTF-8"},
            body: json.encode(requestBody.toJson()))
        .then((response) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print("successful");
        print(response.body);
        return true;
      }
      return false;
    });
  }
}
