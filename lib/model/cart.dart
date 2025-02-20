import 'package:test1_mevivu/model/product_cart.dart';

class Cart {
  int id;
  List<ProductCart> products;
  double total;
  int userId;
  int totalProducts;
  int totalQuantity;

  Cart({
    required this.id,
    required this.products,
    required this.total,
    required this.userId,
    required this.totalProducts,
    required this.totalQuantity,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json["id"],
      products: (json['products'] as List?)!
          .map((x) => ProductCart.fromJson(x))
          .toList(),
      total: json["total"].toDouble(),
      userId: json["userId"],
      totalProducts: json["totalProducts"],
      totalQuantity: json["totalQuantity"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "products": products.map((x) => x.toJson()).toList(),
      "userId": userId,
      "total": total,
      "totalProducts": totalProducts,
      "totalQuantity": totalQuantity,
    };
  }
}
