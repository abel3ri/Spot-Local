import 'dart:io';

import 'package:business_dir/app/modules/image_picker/controllers/image_picker_controller.dart';
import 'package:business_dir/app/modules/image_picker/views/image_picker_view.dart';
import 'package:business_dir/app/widgets/r_button.dart';
import 'package:business_dir/app/widgets/r_circular_indicator.dart';
import 'package:business_dir/app/widgets/r_input_field_row.dart';
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
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
        title: Text(
          "Edit profile",
          style: Get.textTheme.bodyMedium!.copyWith(
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
              Stack(
                children: [
                  Obx(
                    () {
                      if (imagePickController.imagePath.value != null) {
                        return CircleAvatar(
                          radius: 32,
                          backgroundImage: FileImage(
                            File(imagePickController.imagePath.value!),
                          ),
                        );
                      }
                      if (controller.currentProfileImage.value!.isNotEmpty) {
                        return RCircularFadeInAssetNetwork(
                          imagePath: controller.currentProfileImage.value!,
                        );
                      }
                      return CircleAvatar(
                        radius: 32,
                        child: Center(
                          child: Icon(Icons.person),
                        ),
                      );
                    },
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
                            maxHeight: Get.height * 0.4,
                          ),
                          showDragHandle: true,
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: Get.theme.primaryColor,
                        radius: 12,
                        child: Icon(
                          Icons.edit_rounded,
                          size: 18,
                          // color: context.theme.colorScheme.primary,
                        ),
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
              RButton(
                child: Obx(() => controller.isLoading.isTrue
                    ? RCircularIndicator()
                    : Text("Submit".tr)),
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
                      "image": imagePickController.imagePath.value != null
                          ? File(imagePickController.imagePath.value!)
                          : null,
                    };
                    await controller.updateUser(userData: userData);
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

class RCircularFadeInAssetNetwork extends StatelessWidget {
  const RCircularFadeInAssetNetwork({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 32,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: FadeInImage.assetNetwork(
          placeholder: "assets/image.png",
          image: imagePath,
          fit: BoxFit.cover,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset("assets/image.png");
          },
        ),
      ),
    );
  }
}
