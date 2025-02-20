import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1_mevivu/model/product.dart';
import 'package:test1_mevivu/service/product_service.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(() => ProductController());
  }
}

class ProductController extends GetxController {
  var categories = ["Women", "Men", "Shoes", "Watch"].obs;
  var cateIcon = [
    Icons.female,
    Icons.male,
    Icons.smartphone,
    Icons.watch
  ].obs;

  final Map<String, String> cateMap = {
    "Women": "womens-dresses",
    "Men": "mens-shirts",
    "Shoes": "mens-shoes",
    "Watch": "womens-watches"
  };

  var selectCateIndex = 0.obs;
  var products = <Product>[].obs;
  var isLoading = false.obs;
  
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchProduct(cateMap[categories[0]]!);
  }

  void fetchProduct(String category) async {
    try{
      isLoading.value = true;
      var getProducts = await ProductService().getProducts(category);
      products.assignAll(getProducts);
    } catch(e) {
      if (Get.context != null) {
        Get.snackbar(
          'Error',
          'An error occurred while fetching products',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  void changeCate(int index){
    selectCateIndex.value = index;
    var cate = cateMap[categories[index]]!;
    fetchProduct(cate);
  }
}