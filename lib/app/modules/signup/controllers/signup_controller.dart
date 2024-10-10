import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final obscureText = true.obs;
  Rx<bool> isLoading = false.obs;

  void toggleShowPassword() {
    obscureText.value = !obscureText.value;
  }

  @override
  void onClose() {
    super.onClose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    userNameController.dispose();
  }
}
