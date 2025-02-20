import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:test1_mevivu/controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  final controller = Get.find<LoginController>();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Log into",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Text(
                "your account",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: controller.usernameController,
                decoration: InputDecoration(hintText: "Username"),
              ),
              Obx(
                () => TextFormField(
                  controller: controller.passwordController,
                  obscureText: !controller.showPassword.value,
                  decoration: InputDecoration(
                    hintText: "Password",
                    suffixIcon: InkWell(
                      onTap: controller.hiddenPassword,
                      child: controller.showPassword.value == false
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff2D201C),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    controller.login(controller.usernameController.text,
                        controller.passwordController.text);
                  },
                  child: const Text(
                    "LOG IN",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text("or log in with"),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black26),
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.apple,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 8,),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black26),
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 8,),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black26),
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.facebook,
                      color: Colors.black,
                      size: 24,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 40,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ", style: TextStyle(color: Colors.black),),
                  TextButton(onPressed: (){}, child: Text("Sign Up", style: TextStyle(color: Colors.black, decoration: TextDecoration.underline),))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
