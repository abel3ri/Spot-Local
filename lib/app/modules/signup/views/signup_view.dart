import 'dart:io';

import 'package:business_dir/app/controllers/auth_controller.dart';
import 'package:business_dir/app/modules/image_picker/controllers/image_picker_controller.dart';
import 'package:business_dir/app/modules/image_picker/views/image_picker_view.dart';
import 'package:business_dir/app/widgets/r_button.dart';
import 'package:business_dir/app/widgets/r_circular_indicator.dart';
import 'package:business_dir/app/widgets/r_form_footer.dart';
import 'package:business_dir/app/widgets/r_input_field_row.dart';
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
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "readyToExplore".tr,
                  style: Get.textTheme.headlineSmall!.copyWith(
                    color: context.theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.04),
              Stack(
                children: [
                  Obx(
                    () => CircleAvatar(
                      radius: 36,
                      backgroundColor:
                          context.theme.colorScheme.primary.withOpacity(.2),
                      backgroundImage:
                          imagePickController.imagePath.value != null
                              ? FileImage(
                                  File(imagePickController.imagePath.value!))
                              : null,
                      child: imagePickController.imagePath.value == null
                          ? Icon(Icons.person, size: 32)
                          : SizedBox(),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor:
                              context.theme.scaffoldBackgroundColor,
                          context: context,
                          builder: (context) => const ImagePickerView(),
                          constraints: BoxConstraints(
                            maxHeight: Get.height * 0.3,
                          ),
                          showDragHandle: true,
                        );
                      },
                      child: Icon(
                        Icons.add,
                        size: 24,
                        color: context.theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
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
                    ? RCircularIndicator()
                    : Text("signup".tr)),
                onPressed: () async {
                  if (controller.formKey.currentState!.validate()) {
                    if (Get.focusScope?.hasFocus ?? false) {
                      Get.focusScope?.unfocus();
                    }
                    final userData = {
                      "email": controller.emailController.text,
                      "username": controller.userNameController.text,
                      "firstName": controller.firstNameController.text,
                      "lastName": controller.lastNameController.text,
                      "password": controller.passwordController.text,
                      "confirmPassword": controller.rePasswordController.text,
                    };
                    await authController.signup(userData: userData);
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
