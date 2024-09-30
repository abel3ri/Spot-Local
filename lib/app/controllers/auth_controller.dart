import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:business_dir/app/data/models/user_model.dart';
import 'package:business_dir/app/data/providers/auth_provider.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  Rx<bool> isLoading = false.obs;
  late AuthProvider authProvider;
  @override
  void onInit() {
    authProvider = Get.put(AuthProvider());
    super.onInit();
  }

  Future<void> signup({required Map<String, dynamic> userData}) async {
    isLoading(true);
    final res = await authProvider.signup(userData: userData);
    isLoading(false);
    res.fold((AppErrorModel l) {
      l.showError();
    }, (UserModel user) {
      currentUser(user);
      Get.offNamed("/home-wrapper");
    });
  }

  Future<void> login({required Map<String, dynamic> userData}) async {
    isLoading(true);
    final res = await authProvider.login(userData: userData);
    isLoading(false);
    res.fold((AppErrorModel l) {
      l.showError();
    }, (UserModel user) {
      currentUser(user);
      Get.offNamed("/home-wrapper");
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
    isLoading(true);
    currentUser(null);
    final res = await authProvider.logout();
    isLoading(false);
    res.fold((AppErrorModel l) {
      l.showError();
    }, (r) {
      currentUser.value = null;
    });
  }

  @override
  void onClose() {
    super.onClose();
    authProvider.dispose();
  }
}
