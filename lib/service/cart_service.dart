import 'dart:convert';

import 'package:get/get.dart';
import 'package:test1_mevivu/model/add_cart_request.dart';
import 'package:test1_mevivu/model/cart.dart';
import 'package:http/http.dart' as http;

class CartService {
  Future<Cart?> getCartUser(int userId) async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/carts/user/$userId'));

    if (response.statusCode == 200) {
      final bodyContent = utf8.decode(response.bodyBytes);
      final parseContent = jsonDecode(bodyContent);
      if (parseContent["carts"] is List &&
          (parseContent["carts"] as List).isEmpty) {
        return null;
      }
      return Cart.fromJson(parseContent);
    } else {
      final errorBody = utf8.decode(response.bodyBytes);
      final errorData = jsonDecode(errorBody) as Map<String, dynamic>;
      throw Exception(errorData['message']);
    }
  }

  Future<Cart?> addToCart(AddCartRequest addCartRequest) async {
    var response = await http.post(
      Uri.parse('https://dummyjson.com/carts/add'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(addCartRequest.toJson()),
    );

    if(response.statusCode == 200 || response.statusCode == 201){
      final bodyContent = utf8.decode(response.bodyBytes);
      final decode = jsonDecode(bodyContent);
      var result = Cart.fromJson(decode);
      return result;
    } else {
      final errorBody = utf8.decode(response.bodyBytes);
      final errorData = jsonDecode(errorBody) as Map<String, dynamic>;
      throw Exception(errorData['message']);
    }
  }
}
