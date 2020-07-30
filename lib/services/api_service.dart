import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/LoginRequest.dart';
import '../models/Response.dart';
import '../models/User.dart';

class ApiService {
  static const String _API_ENDPOINT = "https://test-api.talkremit.com";

  static Future<UserResponse> login(LoginRequest requestBody) async {
    print("login | body: ${requestBody.toString()}");

    final response = await http.post("$_API_ENDPOINT/user/login",
        headers: {"Content-type": "application/json; charset=UTF-8"},
        body: json.encode(requestBody.toJson()));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Response<User> body = UserResponse(json.decode(response.body));
    if (response.statusCode == 200) {
      print("login successful");
      return body;
    }
    throw Exception(body);
  }
}
