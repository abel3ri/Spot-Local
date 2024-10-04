import 'package:business_dir/app/widgets/r_circular_indicator.dart';
import 'package:business_dir/app/widgets/r_input_field_row.dart';
import 'package:business_dir/utils/form_validation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          iconSize: 24,
        ),
        title: Text(
          'Reset password',
          style: Get.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Form(
          key: controller.formKey,
          child: Obx(
            () => Column(
              children: [
                RInputField(
                  controller: controller.otpController,
                  label: "OTP",
                  hintText: "Enter OTP sent to your email address",
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  validator: FormValidator.otpValidator,
                ),
                SizedBox(height: Get.height * 0.02),
                if (controller.isTimerActive.isTrue)
                  Text(
                    "Resend OTP in ${controller.secondsRemaining.value} seconds",
                    style: TextStyle(color: Colors.grey),
                  )
                else
                  GestureDetector(
                    onTap: controller.resendOTP,
                    child: Text(
                      "Resend OTP",
                      style: TextStyle(
                        color: Get.theme.colorScheme.secondary,
                      ),
                    ),
                  ),
                SizedBox(height: Get.height * 0.02),
                RInputField(
                  controller: controller.passwordController,
                  label: "New Password",
                  hintText: "Enter your new password",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  obscureText: controller.obscureText.value,
                  validator: FormValidator.passwordValidtor,
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.toggleShowPassword();
                    },
                    icon: Icon(
                      controller.obscureText.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                RInputField(
                  controller: controller.repassController,
                  label: "Re-type password",
                  hintText: "Retype your new password",
                  obscureText: controller.obscureText.value,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    return FormValidator.confirmPasswordValidator(
                      password: controller.passwordController.text,
                      rePassword: value,
                    );
                  },
                ),
                SizedBox(height: Get.height * 0.02),
                FilledButton(
                  child: Obx(() => controller.isLoading.isTrue
                      ? RCircularIndicator()
                      : Text("Reset password")),
                  onPressed: () async {
                    if (controller.formKey.currentState!.validate()) {
                      if (Get.focusScope?.hasFocus ?? false) {
                        Get.focusScope!.unfocus();
                      }
                      await controller.resetPassword();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
