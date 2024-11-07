import 'dart:io';

import 'package:business_dir/app/controllers/auth_controller.dart';
import 'package:business_dir/app/data/providers/user_provider.dart';
import 'package:business_dir/app/modules/image_picker/controllers/image_picker_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  Rx<String?> currentProfileImage = Rx<String?>(null);
  final formKey = GlobalKey<FormState>();
  late UserProvider userProvider;
  late AuthController authController;
  final obscureText = true.obs;
  Rx<bool> isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    userProvider = Get.find<UserProvider>();
    authController = Get.find<AuthController>();
    final currentUser = authController.currentUser.value;
    firstNameController.text = currentUser?.firstName ?? "";
    lastNameController.text = currentUser?.lastName ?? "";
    emailController.text = currentUser?.email ?? "";
    userNameController.text = currentUser?.username ?? "";
    currentProfileImage.value = currentUser?.profileImage?['url'] ?? "";
  }

  void toggleShowPassword() {
    obscureText.value = !obscureText.value;
  }

  Future<void> updateUser() async {
    final imagePickController = Get.find<ImagePickerController>();
    final userData = {
      "email": emailController.text,
      "username": userNameController.text,
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "profile_image": imagePickController.profileImagePath.value != null
          ? File(imagePickController.profileImagePath.value!)
          : null,
    };
    isLoading(true);
    final res = await userProvider.updateOne(
        userData: userData, userId: authController.currentUser.value!.id!);
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) {
      authController.currentUser.value = r;
      Get.back();
    });
  }

  @override
  void onClose() {
    super.onClose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    userNameController.dispose();
  }
}
