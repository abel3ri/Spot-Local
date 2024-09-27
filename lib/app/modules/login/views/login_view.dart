import 'package:business_dir/app/widgets/form_footer.dart';
import 'package:business_dir/app/widgets/input_field_row.dart';
import 'package:business_dir/app/widgets/r_button.dart';
import 'package:business_dir/utils/form_validation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final loginController = Get.find<LoginController>();
  LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: loginController.formKey,
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "welcomeBack".tr,
                    style: Get.textTheme.headlineSmall!.copyWith(
                      color: Get.theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.04),
                RInputField(
                  controller: loginController.emailController,
                  label: "email".tr,
                  hintText: "enterEmail".tr,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: FormValidator.emailValidator,
                ),
                SizedBox(height: Get.height * 0.02),
                RInputField(
                  controller: loginController.passwordController,
                  label: "password".tr,
                  hintText: "enterPassword".tr,
                  obscureText: loginController.obscureText.value,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  suffixIcon: IconButton(
                    onPressed: () {
                      loginController.toggleShowPassword();
                    },
                    icon: Icon(
                      loginController.obscureText.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                  validator: FormValidator.passwordValidtor,
                ),
                SizedBox(height: Get.height * 0.02),
                RButton(
                  child: Text("login".tr),
                  onPressed: () async {
                    if (loginController.formKey.currentState!.validate()) {}
                  },
                ),
                FormFooter(
                  label: "dontHaveAccount".tr,
                  text: 'signup'.tr,
                  onPressed: () {
                    Get.offNamed("signup");
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
