import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test1_mevivu/controller/cart_controller.dart';
import 'package:test1_mevivu/controller/login_controller.dart';
import 'package:test1_mevivu/controller/navigator_controller.dart';
import 'package:test1_mevivu/controller/post_controller.dart';
import 'package:test1_mevivu/controller/product_controller.dart';
import 'package:test1_mevivu/controller/user_controller.dart';
import 'package:test1_mevivu/view/main_page.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => MainPage(),
          bindings: [
            NavigatorBiding(),
            ProductBinding(),
            PostBiding(),
            LoginBinding(),
            UserBiding(),
            CartBiding(),
          ],
        ),
      ],
    );
  }
}
