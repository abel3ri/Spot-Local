import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:business_dir/app/data/models/user_model.dart';
import 'package:business_dir/app/data/providers/auth_provider.dart';
import 'package:business_dir/app/modules/login/controllers/login_controller.dart';
import 'package:business_dir/app/modules/profile/controllers/profile_controller.dart';
import 'package:business_dir/app/modules/signup/controllers/signup_controller.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  AuthProvider authProvider = Get.put(AuthProvider());
  Rx<bool> isLoading = false.obs;

  Future<void> signup({required Map<String, dynamic> userData}) async {
    final signupController = Get.find<SignupController>();
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

  Future<void> login({required Map<String, dynamic> userData}) async {
    final loginController = Get.find<LoginController>();
    loginController.isLoading(true);
    final res = await authProvider.login(userData: userData);
    loginController.isLoading(false);
    res.fold((AppErrorModel l) {
      l.showError();
    }, (UserModel user) {
      currentUser(user);
      Get.offAllNamed("/home-wrapper");
    });
  }

  Future<void> getUserData() async {
    isLoading(true);
    final res = await authProvider.getUserData();
    isLoading(false);
    res.fold((AppErrorModel l) {
      if (l.body != "No user found!") l.showError();
    }, (UserModel user) {
      currentUser(user);
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
