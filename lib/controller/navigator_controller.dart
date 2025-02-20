import 'package:get/get.dart';

class NavigatorBiding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<NavigatorController>(() => NavigatorController());
  }
}

class NavigatorController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
