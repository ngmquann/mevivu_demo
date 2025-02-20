import 'dart:convert';

import 'package:get/get.dart';
import 'package:test1_mevivu/model/post.dart';
import 'package:http/http.dart' as http;

class PostService {
  Future<List<Post>> getAllPosts() async {
    final response =
    await http.get(Uri.parse('https://dummyjson.com/posts'));

    if (response.statusCode == 200) {
      final bodyContent = utf8.decode(response.bodyBytes);
      final parseContent = jsonDecode(bodyContent);
      return Post.fromJsonList(parseContent['posts']);
    } else {
      final errorBody = utf8.decode(response.bodyBytes);
      final errorData = jsonDecode(errorBody) as Map<String, dynamic>;
      throw Exception(errorData['message']);
    }
  }
}