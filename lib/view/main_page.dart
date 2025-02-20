import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test1_mevivu/controller/login_controller.dart';
import 'package:test1_mevivu/controller/navigator_controller.dart';
import 'package:test1_mevivu/view/cart_page.dart';
import 'package:test1_mevivu/view/home_page.dart';
import 'package:test1_mevivu/view/login_page.dart';
import 'package:test1_mevivu/view/post_page.dart';
import 'package:test1_mevivu/view/profile_page.dart';

class MainPage extends StatelessWidget {
  final controller = Get.find<NavigatorController>();
  final storage = GetStorage();
  MainPage({super.key});

  final List<Widget> pages = [
    HomePage(),
    PostPage(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          currentIndex: controller.selectedIndex.value,
          onTap: (index) {
            if(index == 3){
              String? token = storage.read("token");
              if(token == null || token.isEmpty){
                Get.lazyPut<LoginController>(() => LoginController());
                Get.to(() => LoginPage());
                return;
              }
            }
            controller.changeIndex(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.newspaper_outlined,
              ),
              label: "Post",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
              ),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
