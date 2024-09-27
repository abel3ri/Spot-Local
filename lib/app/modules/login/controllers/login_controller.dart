import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final obscureText = true.obs;

  void toggleShowPassword() {
    obscureText.value = !obscureText.value;
  }

  @override
  void onClose() {
    super.onClose();
    passwordController.dispose();
    emailController.dispose();
  }
}
