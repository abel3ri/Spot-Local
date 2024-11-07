import 'package:business_dir/app/controllers/auth_controller.dart';
import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:business_dir/app/data/models/app_success_model.dart';
import 'package:business_dir/app/data/providers/featured_provider.dart';
import 'package:business_dir/app/modules/my_businesses/controllers/my_businesses_controller.dart';
import 'package:chapa_unofficial/chapa_unofficial.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class FeatureBusinessController extends GetxController {
  Rx<Map<String, dynamic>?> paymentRate = Rx<Map<String, dynamic>?>(null);
  late MyBusinessesController myBusinessesController;
  late FeaturedProvider featuredProvider;
  late AuthController authController;
  Rx<bool> isLoading = false.obs;
  Rx<int> selectedNumOfDays = 0.obs;

  @override
  void onInit() {
    super.onInit();
    Chapa.configure(
      privateKey: dotenv.env['CHAPA_TEST_PRIVATE_KEY'] ?? "",
    );
    myBusinessesController = Get.find<MyBusinessesController>();
    featuredProvider = Get.find<FeaturedProvider>();
    authController = Get.find<AuthController>();
    getPaymentRate();
  }

  Future<void> pay() async {
    try {
      final business = myBusinessesController.toBeFeaturedBusiness.value;
      final owner = authController.currentUser.value;
      String txRef = TxRefRandomGenerator.generate(prefix: 'Business');
      isLoading(true);
      final res =
          await featuredProvider.checkEligibility(businessId: business!.id!);
      res.fold((l) {
        l.showError();
        isLoading(false);
      }, (r) async {
        try {
          await Chapa.getInstance.startPayment(
            context: Get.context,
            onInAppPaymentSuccess: (successMsg) async {
              await createFeatured();
            },
            onInAppPaymentError: (errorMsg) {
              AppErrorModel(body: errorMsg).showError();
            },
            currency: 'ETB',
            amount: '${paymentRate.value![selectedNumOfDays.value.toString()]}',
            firstName: owner?.firstName,
            lastName: owner?.lastName,
            phoneNumber: business.phone?.first,
            txRef: txRef,
          );
          isLoading(false);
        } on ChapaException catch (e) {
          if (e is AuthException) {
            AppErrorModel(body: 'AuthException ${e.toString()}').showError();
          } else if (e is InitializationException) {
            AppErrorModel(body: 'InitializationException ${e.toString()}')
                .showError();
          } else if (e is NetworkException) {
            AppErrorModel(body: 'NetworkException ${e.toString()}').showError();
          } else if (e is ServerException) {
            AppErrorModel(body: 'ServerException ${e.toString()}').showError();
          } else {
            AppErrorModel(body: 'Unknown error ${e.toString()}').showError();
          }
        } catch (e) {
          AppErrorModel(body: 'Exception ${e.toString()}').showError();
        }
      });
    } catch (e) {
      AppErrorModel(body: '!Exception ${e.toString()}').showError();
    }
  }

  Future<void> createFeatured() async {
    isLoading(true);
    final res = await featuredProvider.create(
      featureData: {
        "paymentAmount": paymentRate.value?[selectedNumOfDays.value.toString()],
        "businessId": myBusinessesController.toBeFeaturedBusiness.value!.id,
        "expiresOn": DateTime.fromMillisecondsSinceEpoch(
          DateTime.now().millisecondsSinceEpoch +
              selectedNumOfDays.value * 24 * 60 * 60 * 1000,
        ).toIso8601String(),
      },
    );
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) {
      Get.back();
      const AppSuccessModel(
        body: "Your request has been sent. We will noify you shortly!",
      ).showSuccess();
    });
  }

  Future<void> getPaymentRate() async {
    isLoading(true);
    final res = await featuredProvider.getPaymentRate();
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) {
      paymentRate.value = r;
    });
  }
}
