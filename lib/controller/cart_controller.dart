import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test1_mevivu/model/add_cart_request.dart';
import 'package:test1_mevivu/model/cart.dart';
import 'package:test1_mevivu/model/product.dart';
import 'package:test1_mevivu/model/product_cart.dart';
import 'package:test1_mevivu/service/cart_service.dart';

class CartBiding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(() => CartController());
  }
}

class CartController extends GetxController {
  final box = GetStorage();
  var cart = Rxn<Cart>();
  var isLoading = false.obs;

  void getCart() async {
    try {
      isLoading.value = true;
      var localCart = box.read("cart");
      final userId = box.read("userId");
      if (userId == null) {
        throw Exception("User ID not found");
      }
      if (localCart != null) {
        cart.value = Cart.fromJson(localCart);
      } else {
        var cartData = await CartService().getCartUser(userId);
        cart.value = cartData;

        if (cartData != null) {
          box.write("cart", cartData.toJson());
        }
      }
    } catch (e) {
      if (Get.context != null) {
        Get.snackbar(
          'Error',
          'An error occurred while fetching cart',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  void addToCart(Product product) async {
    try {
      final userId = box.read("userId");
      if (userId == null) {
        throw Exception("User ID not found");
      }
      var localCart = box.read("cart");
      Cart? currentCart = localCart != null ? Cart.fromJson(localCart) : null;

      List<ProductCart> products = currentCart?.products ?? [];

      int index = products.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        products[index] = ProductCart(
          id: products[index].id,
          title: products[index].title,
          price: products[index].price,
          quantity: products[index].quantity + 1,
          total: (products[index].price ?? 0) * (products[index].quantity + 1),
          thumbnail: products[index].thumbnail,
        );
      } else {
        products.add(ProductCart(
          id: product.id,
          title: product.title,
          price: product.price,
          quantity: 1,
          total: product.price,
          thumbnail: product.thumbnail,
        ));
      }

      AddCartRequest addCartRequest = AddCartRequest(
        userId: userId,
        products: products,
      );

      var response = await CartService().addToCart(addCartRequest);
      if (response != null) {
        box.write("cart", response.toJson());
        cart.value = response;

        if (Get.context != null) {
          Get.snackbar(
            'Success',
            'Added to cart successfully',
            snackPosition: SnackPosition.TOP,
          );
        }
      }
    } catch (e) {
      if (Get.context != null) {
        Get.snackbar(
          'Error',
          'An error occurred while adding to cart',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }
}
