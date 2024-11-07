import 'package:business_dir/app/controllers/auth_controller.dart';
import 'package:business_dir/app/widgets/r_button.dart';
import 'package:business_dir/app/widgets/r_circular_indicator.dart';
import 'package:business_dir/app/widgets/r_form_footer.dart';
import 'package:business_dir/app/widgets/r_input_field_row.dart';
import 'package:business_dir/app/widgets/r_text_icon_button.dart';
import 'package:business_dir/utils/form_validation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final authController = Get.find<AuthController>();
  LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final String? previousRoute = Get.arguments?['previousRoute'];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: ['/get-started', "business-details"].contains(previousRoute)
            ? IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              )
            : null,
        actions: [
          if (!['/get-started', "business-details"].contains(previousRoute))
            RTextIconButton(
              label: "Skip",
              icon: Icons.arrow_right_alt_rounded,
              onPressed: () {
                Get.offAllNamed("/home-wrapper");
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "welcomeBack".tr,
                  style: context.textTheme.headlineMedium!.copyWith(
                    color: context.theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.04),
              RInputField(
                controller: controller.emailController,
                label: "email".tr,
                hintText: "enterEmail".tr,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: FormValidator.emailValidator,
              ),
              SizedBox(height: Get.height * 0.02),
              Obx(
                () => RInputField(
                  controller: controller.passwordController,
                  label: "password".tr,
                  hintText: "enterPassword".tr,
                  obscureText: controller.obscureText.value,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  suffixIcon: IconButton(
                    focusNode: FocusNode(skipTraversal: true),
                    onPressed: () {
                      controller.toggleShowPassword();
                    },
                    icon: Icon(
                      controller.obscureText.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                  validator: FormValidator.passwordValidtor,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Get.toNamed("forgot-password");
                  },
                  child: Text(
                    "forgotPassword".tr,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.theme.primaryColor,
                        ),
                  ),
                ),
              ),
              RButton(
                child: Obx(
                  () {
                    return controller.isLoading.isTrue
                        ? const RCircularIndicator()
                        : Text("login".tr);
                  },
                ),
                onPressed: () async {
                  if (controller.formKey.currentState!.validate()) {
                    if (Get.focusScope?.hasFocus ?? false) {
                      Get.focusScope?.unfocus();
                    }

                    await authController.login();
                  }
                },
              ),
              RFormFooter(
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
    );
  }
}
