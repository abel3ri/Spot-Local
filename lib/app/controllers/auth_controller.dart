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
    final res = await authProvider.signupUser(userData: userData);
    isLoading(false);
    res.fold((AppErrorModel l) {
      l.showError();
    }, (UserModel user) {
      currentUser(user);
    });
  }

  Future<void> login({required Map<String, dynamic> userData}) async {
    isLoading(true);
    final res = await authProvider.loginUser(userData: userData);
    isLoading(false);
    res.fold((AppErrorModel l) {
      l.showError();
    }, (UserModel user) {
      currentUser(user);
    });
  }

  Future<void> getUserData() async {
    isLoading(true);
    final res = await authProvider.getUserData();
    isLoading(false);
    res.fold((AppErrorModel l) {
      l.showError();
    }, (UserModel user) {
      currentUser(user);
    });
  }

  Future<void> logout() async {
    isLoading(true);
    final res = await authProvider.logout();
    isLoading(false);
    res.fold((AppErrorModel l) {
      l.showError();
    }, (r) {
      currentUser(null);
    });
  }

  @override
  void onClose() {
    super.onClose();
    authProvider.dispose();
  }
}
