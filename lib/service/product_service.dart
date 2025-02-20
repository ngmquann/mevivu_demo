import 'dart:convert';

import 'package:get/get.dart';
import 'package:test1_mevivu/model/product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<List<Product>> getProducts(String category) async {
    final response = await http
        .get(Uri.parse('https://dummyjson.com/products/category/$category'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Product> fetchedProducts = (data['products'] as List)
          .map((product) => Product(
                id: product['id'],
                title: product['title'],
                description: product['description'],
                category: product['category'],
                price: product['price'].toDouble(),
                thumbnail: product['thumbnail'],
                images: List<String>.from(product['images']),
              ))
          .toList();
      return fetchedProducts;
    } else {
      final errorBody = utf8.decode(response.bodyBytes);
      final errorData = jsonDecode(errorBody) as Map<String, dynamic>;
      throw Exception(errorData['message']);
    }
  }
}
