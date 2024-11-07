import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:business_dir/app/data/models/app_success_model.dart';
import 'package:business_dir/app/data/models/business_model.dart';
import 'package:business_dir/app/data/models/featured_model.dart';
import 'package:business_dir/app/data/providers/auth_provider.dart';
import 'package:business_dir/utils/error_handler.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

class FeaturedProvider extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    // httpClient.baseUrl = 'http://10.0.2.2:8000/api/v1/cities';
    httpClient.baseUrl =
        "https://businessdirectory-vnct9q98.b4a.run/api/v1/featureds";
    httpClient.timeout = const Duration(seconds: 60);
  }

  Future<Either<AppErrorModel, List<FeaturedModel>>> findAll({
    Map<String, dynamic>? query,
  }) async {
    try {
      final res = await get("/", query: query);
      handleError(res);
      final featureds = List<FeaturedModel>.from(
        res.body['data'].map(
          (featured) => FeaturedModel.fromJson(featured),
        ),
      );

      return right(featureds);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, FeaturedModel>> updateOne({
    required String featuredId,
    required String status,
  }) async {
    try {
      final token =
          await Get.find<AuthProvider>().secureStorage.read(key: "jwtToken");
      final res = await patch(
        "/$featuredId",
        {
          "status": status,
        },
        headers: {"Authorization": "Bearer $token"},
      );
      handleError(res);
      final featured = FeaturedModel.fromJson(res.body['data']);
      return right(featured);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, List<BusinessModel>>> findFeaturedBusinesses(
      {Map<String, dynamic>? query}) async {
    try {
      final token =
          await Get.find<AuthProvider>().secureStorage.read(key: "jwtToken");
      final res = await get(
        "/",
        query: query,
        headers: {"Authorization": "Bearer $token"},
      );
      handleError(res);
      final businesses = List<BusinessModel>.from(
        res.body['data'].map(
          (featured) => BusinessModel.fromJson(
            featured['business'],
          ),
        ),
      );

      return right(businesses);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, FeaturedModel>> create({
    required Map<String, dynamic> featureData,
  }) async {
    try {
      final token =
          await Get.find<AuthProvider>().secureStorage.read(key: "jwtToken");
      final res = await post(
        "/",
        featureData,
        headers: {"Authorization": "Bearer $token"},
      );
      handleError(res);
      final featured = FeaturedModel.fromJson(res.body['data']);
      return right(featured);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, AppSuccessModel>> checkEligibility(
      {required String businessId}) async {
    try {
      final res = await get("/check-eligibility/$businessId");
      handleError(res);
      return right(AppSuccessModel(body: res.body['message']));
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, Map<String, dynamic>>> getPaymentRate() async {
    try {
      final res = await get("/payment-rate");
      handleError(res);
      return right(res.body['data']);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, List<FeaturedModel>>> myFeatures() async {
    try {
      final token =
          await Get.find<AuthProvider>().secureStorage.read(key: "jwtToken");
      final res = await get(
        "/feature-history",
        headers: {"Authorization": "Bearer $token"},
      );
      handleError(res);
      final featureds =
          List<FeaturedModel>.from(res.body['data'].map((featured) {
        return FeaturedModel.fromJson(featured['featured']);
      }));
      return right(featureds);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }
}
