import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:test1_mevivu/model/user.dart';
import 'package:test1_mevivu/service/user_service.dart';

class UserBiding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController());
  }
}

class UserController extends GetxController {
  final box = GetStorage();
  final user = Rxn<User>();
  var isLoading = false.obs;

  void getCurrentUser() async {
    try{
      isLoading.value = true;
      var result = await UserService().getCurrentUser(box.read("token"));
      user.value = result!;
    } catch(e) {
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
}