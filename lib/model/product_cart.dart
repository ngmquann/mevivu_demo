class ProductCart {
  int id;
  String? title;
  double? price;
  int quantity;
  double? total;
  String? thumbnail;

  ProductCart({
    required this.id,
    this.title,
    this.price,
    required this.quantity,
    this.total,
    this.thumbnail,
  });

  factory ProductCart.fromJson(Map<String, dynamic> json) {
    return ProductCart(
      id: json["id"],
      title: json["title"],
      quantity: json["quantity"],
      total: json["total"],
      price: json["price"],
      thumbnail: json["thumbnail"],
    );
  }

  Map<String, dynamic> toJson2() {
    return {
      "id": id,
      "quantity": quantity,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "quantity": quantity,
      "total": total,
      "price": price,
      "thumbnail": thumbnail,
    };
  }

  static List<ProductCart> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ProductCart.fromJson(json)).toList();
  }
}
