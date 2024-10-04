import 'dart:async';

import 'package:business_dir/app/controllers/auth_controller.dart';
import 'package:business_dir/app/data/providers/auth_provider.dart';
import 'package:business_dir/app/modules/forgot_password/controllers/forgot_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repassController = TextEditingController();
  late AuthProvider authProvider;
  late AuthController authController;
  final formKey = GlobalKey<FormState>();
  Rx<bool> isLoading = false.obs;
  final obscureText = true.obs;

  Rx<bool> isTimerActive = true.obs;
  Rx<int> secondsRemaining = 60.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
    authProvider = Get.find<AuthProvider>();
    authController = Get.find<AuthController>();
  }

  void startTimer() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (secondsRemaining.value > 0) {
          secondsRemaining.value--;
        } else {
          isTimerActive.value = false;
          _timer?.cancel();
        }
      },
    );
  }

  void resendOTP() async {
    final forgotPasswordController = Get.find<ForgotPasswordController>();
    await forgotPasswordController.sendOTP();
    secondsRemaining.value = 60;
    isTimerActive.value = true;
    startTimer();
  }

  Future<void> resetPassword() async {
    isLoading(true);
    final res = await authProvider.resetPassword(
        otp: int.parse(otpController.text),
        password: passwordController.text,
        confirmPassword: repassController.text);
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) {
      authController.currentUser.value = r;
      Get.offNamed("/home-wrapper");
    });
  }

  void toggleShowPassword() {
    obscureText.value = !obscureText.value;
  }

  @override
  void onClose() {
    super.onClose();

    otpController.dispose();
    passwordController.dispose();
    repassController.dispose();
  }
}
