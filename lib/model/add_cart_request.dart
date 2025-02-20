import 'package:test1_mevivu/model/product.dart';
import 'package:test1_mevivu/model/product_cart.dart';

class AddCartRequest {
  int userId;
  List<ProductCart> products;

  AddCartRequest({
    required this.userId,
    required this.products,
  });

  factory AddCartRequest.fromJson(Map<String, dynamic> json) {
    return AddCartRequest(
      userId: json["userId"],
        products: (json['products'] as List?)!
          .map((x) => ProductCart.fromJson(x))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "products": products.map((x) => x.toJson2()).toList(),
    };
  }
}
