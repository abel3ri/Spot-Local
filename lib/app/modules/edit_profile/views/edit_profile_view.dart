import 'package:business_dir/app/modules/image_picker/controllers/image_picker_controller.dart';
import 'package:business_dir/app/widgets/r_button.dart';
import 'package:business_dir/app/widgets/r_circular_indicator.dart';
import 'package:business_dir/app/widgets/r_input_field_row.dart';
import 'package:business_dir/app/widgets/r_picked_image_placeholder.dart';
import 'package:business_dir/utils/form_validation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  EditProfileView({super.key});
  final imagePickController = Get.find<ImagePickerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
        title: Text(
          "editProfile".tr,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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
              RPickedImagePlaceholder(
                imageType: "profile_image",
                label: "Pick profile image",
                placeholderText: "profile",
                imagePath: imagePickController.profileImagePath,
                currentImageUrl: controller.currentProfileImage.value,
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
              RButton(
                child: Obx(() => controller.isLoading.isTrue
                    ? const RCircularIndicator()
                    : Text(
                        "submit".tr,
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )),
                onPressed: () async {
                  if (controller.formKey.currentState!.validate()) {
                    if (Get.focusScope?.hasFocus ?? false) {
                      Get.focusScope?.unfocus();
                    }

                    await controller.updateUser();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
