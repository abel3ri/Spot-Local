import 'package:business_dir/app/data/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late AuthProvider authProvider;
  Rx<bool> isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    authProvider = Get.find<AuthProvider>();
  }

  Future<void> sendOTP() async {
    isLoading(true);
    final res = await authProvider.sendOTP(email: emailController.text);
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) {
      r.showSuccess();
      Get.toNamed("reset-password");
    });
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
  }
}
