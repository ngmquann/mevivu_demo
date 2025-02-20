import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test1_mevivu/model/login_request.dart';
import 'package:test1_mevivu/model/login_response.dart';

class AuthService {
  Future<LoginResponse?> login(LoginRequest loginRequest) async {
    var response = await http.post(
        Uri.parse('https://dummyjson.com/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(loginRequest.toJson()));
    if (response.statusCode == 200) {
      final bodyContent = utf8.decode(response.bodyBytes);
      return LoginResponse.fromJson(jsonDecode(bodyContent));
    } else {
      final errorBody = utf8.decode(response.bodyBytes);
      final errorData = jsonDecode(errorBody) as Map<String, dynamic>;
      throw Exception(errorData['message']);
    }
  }
}
