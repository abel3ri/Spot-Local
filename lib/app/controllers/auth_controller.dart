import 'dart:io';

import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:business_dir/app/data/models/user_model.dart';
import 'package:business_dir/app/data/providers/auth_provider.dart';
import 'package:business_dir/app/modules/image_picker/controllers/image_picker_controller.dart';
import 'package:business_dir/app/modules/login/controllers/login_controller.dart';
import 'package:business_dir/app/modules/profile/controllers/profile_controller.dart';
import 'package:business_dir/app/modules/signup/controllers/signup_controller.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  AuthProvider authProvider = Get.put(AuthProvider());
  Rx<bool> isLoading = false.obs;
  late SignupController signupController;

  Future<void> signup() async {
    final signupController = Get.find<SignupController>();
    final imagePickController = Get.find<ImagePickerController>();
    final userData = {
      "email": signupController.emailController.text,
      "username": signupController.userNameController.text,
      "firstName": signupController.firstNameController.text,
      "lastName": signupController.lastNameController.text,
      "password": signupController.passwordController.text,
      "confirmPassword": signupController.rePasswordController.text,
      "profile_image": imagePickController.profileImagePath.value != null
          ? File(imagePickController.profileImagePath.value!)
          : null,
    };
    signupController.isLoading(true);
    final res = await authProvider.signup(userData: userData);
    signupController.isLoading(false);
    res.fold((AppErrorModel l) {
      l.showError();
    }, (UserModel user) {
      currentUser(user);
      Get.offAllNamed("/home-wrapper");
    });
  }

  Future<void> login() async {
    final loginController = Get.find<LoginController>();
    Map<String, dynamic> userData = {
      "email": loginController.emailController.text,
      "password": loginController.passwordController.text,
    };
    loginController.isLoading(true);
    final res = await authProvider.login(userData: userData);
    loginController.isLoading(false);
    res.fold((AppErrorModel l) {
      l.showError();
    }, (UserModel user) {
      currentUser(user);
      Get.offAllNamed("/splash");
    });
  }

  Future<void> getUserData() async {
    isLoading(true);
    final res = await authProvider.getUserData();
    isLoading(false);
    res.fold((AppErrorModel l) {
      if (l.body != "No user found!") l.showError();
    }, (UserModel user) {
      currentUser.value = user;
    });
  }

  Future<void> logout() async {
    final profileController = Get.find<ProfileController>();
    profileController.isLoading(true);
    currentUser(null);
    final res = await authProvider.logout();
    profileController.isLoading(false);
    res.fold((AppErrorModel l) {
      l.showError();
    }, (r) {
      currentUser.value = null;
      Get.offAllNamed("/get-started");
    });
  }

  @override
  void onClose() {
    super.onClose();
    authProvider.dispose();
  }
}
