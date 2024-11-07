import 'package:business_dir/app/controllers/auth_controller.dart';
import 'package:business_dir/app/data/providers/user_provider.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  Rx<bool> isLoading = false.obs;
  late UserProvider userProvider;
  late AuthController authController;

  @override
  void onInit() {
    userProvider = Get.find<UserProvider>();
    authController = Get.find<AuthController>();
    super.onInit();
  }

  Future<void> deleteAccount() async {
    isLoading(true);
    final res = await userProvider.deleteOne(
      userId: authController.currentUser.value!.id!,
    );
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) {
      authController.currentUser.value = null;
      Get.offAllNamed("/get-started");
    });
  }
}
