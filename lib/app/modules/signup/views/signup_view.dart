import 'package:business_dir/app/controllers/auth_controller.dart';
import 'package:business_dir/app/modules/image_picker/controllers/image_picker_controller.dart';
import 'package:business_dir/app/widgets/r_button.dart';
import 'package:business_dir/app/widgets/r_circular_indicator.dart';
import 'package:business_dir/app/widgets/r_form_footer.dart';
import 'package:business_dir/app/widgets/r_input_field_row.dart';
import 'package:business_dir/app/widgets/r_picked_image_placeholder.dart';
import 'package:business_dir/app/widgets/r_text_icon_button.dart';
import 'package:business_dir/utils/form_validation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  SignupView({super.key});
  final imagePickController = Get.find<ImagePickerController>();
  final authController = Get.find<AuthController>();

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
                  "readyToExplore".tr,
                  style: context.textTheme.headlineMedium!.copyWith(
                    color: context.theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.04),
              RPickedImagePlaceholder(
                imageType: "profile_image",
                label: "Pick profile image",
                placeholderText: "profile",
                imagePath: imagePickController.profileImagePath,
              ),
              SizedBox(height: Get.height * 0.04),
              Row(
                children: [
                  Expanded(
                    child: RInputField(
                      controller: controller.firstNameController,
                      label: "firstName".tr,
                      hintText: "enterFirstName".tr,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: FormValidator.nameValidator,
                    ),
                  ),
                  SizedBox(width: Get.width * 0.04),
                  Expanded(
                    child: RInputField(
                      controller: controller.lastNameController,
                      label: "lastName".tr,
                      hintText: "enterLastName".tr,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: FormValidator.nameValidator,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              RInputField(
                controller: controller.userNameController,
                label: "username".tr,
                hintText: "enterUsername".tr,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: FormValidator.usernameValidator,
              ),
              SizedBox(height: Get.height * 0.02),
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
              SizedBox(height: Get.height * 0.02),
              Obx(
                () => RInputField(
                  controller: controller.rePasswordController,
                  label: "confirmPassword".tr,
                  hintText: "enterRePassword".tr,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: controller.obscureText.value,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    return FormValidator.confirmPasswordValidator(
                      password: controller.passwordController.text,
                      rePassword: value,
                    );
                  },
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              RButton(
                child: Obx(() => controller.isLoading.isTrue
                    ? const RCircularIndicator()
                    : Text("signup".tr)),
                onPressed: () async {
                  if (controller.formKey.currentState!.validate()) {
                    if (Get.focusScope?.hasFocus ?? false) {
                      Get.focusScope?.unfocus();
                    }
                    await authController.signup();
                  }
                },
              ),
              RFormFooter(
                label: "alreadyHaveAccount".tr,
                text: 'login'.tr,
                onPressed: () {
                  Get.offNamed("login");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
