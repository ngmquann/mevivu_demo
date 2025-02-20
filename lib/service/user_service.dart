import 'dart:convert';

import 'package:test1_mevivu/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class UserService {
  Future<User?> getCurrentUser(String token) async {
    var response = await http.get(
      Uri.parse('https://dummyjson.com/auth/me'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if(response.statusCode == 200){
      final bodyContent = utf8.decode(response.bodyBytes);
      return User.fromJson(jsonDecode(bodyContent));
    } else {
      final errorBody = utf8.decode(response.bodyBytes);
      final errorData = jsonDecode(errorBody) as Map<String, dynamic>;
      throw Exception(errorData['message']);
    }
  }
}
