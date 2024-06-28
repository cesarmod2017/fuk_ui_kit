import 'package:flutter/material.dart';
import 'package:fuk_ui_kit_sample/modules/login/controller/login_controller.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Login",
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: const Column(
          children: [
            Center(
              child: Text("Login"),
            ),
          ],
        ),
      );
    });
  }
}
