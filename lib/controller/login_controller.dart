import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test1_mevivu/controller/navigator_controller.dart';
import 'package:test1_mevivu/model/login_request.dart';
import 'package:test1_mevivu/service/auth_service.dart';
import 'package:test1_mevivu/view/main_page.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final showPassword = false.obs;
  final box = GetStorage();

  void hiddenPassword() {
    showPassword.value = !showPassword.value;
  }

  void login(String username, String password) async {
    try {
      var result = await AuthService().login(
        LoginRequest(username: username, password: password),
      );
      box.write("token", result!.token);
      box.write("userId", result.id);
      Get.offAllNamed("/");
    } catch(e) {
      if (Get.context != null) {
        Get.snackbar(
          'Error',
          'An error occurred while login',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  void logout(){
    box.remove("token");
    box.remove("userId");
    box.remove("cart");
    // Get.find<NavigatorController>().changeIndex(0);
    Get.offAllNamed("/");
  }
}
