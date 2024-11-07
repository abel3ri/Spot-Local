import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:business_dir/app/data/models/app_success_model.dart';
import 'package:business_dir/app/data/models/favorite_model.dart';
import 'package:business_dir/app/data/providers/auth_provider.dart';
import 'package:business_dir/utils/error_handler.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

class FavoriteProvider extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl =
        "https://businessdirectory-vnct9q98.b4a.run/api/v1/favorites";
    httpClient.timeout = const Duration(seconds: 60);
  }

  Future<Either<AppErrorModel, List<FavoriteModel>>> findAll({
    Map<String, dynamic>? query,
  }) async {
    try {
      final secureStorage = Get.find<AuthProvider>().secureStorage;
      final token = await secureStorage.read(key: "jwtToken");
      final res = await get("/", headers: {"Authorization": "Bearer $token"});
      handleError(res);
      final favorites = List<FavoriteModel>.from(
        res.body['data'].map((favorite) {
          return FavoriteModel.fromJson(favorite);
        }),
      );
      return right(favorites);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, AppSuccessModel>> create({
    required String businessId,
  }) async {
    try {
      final secureStorage = Get.find<AuthProvider>().secureStorage;
      final token = await secureStorage.read(key: "jwtToken");
      final res = await post("/", {
        "businessId": businessId,
      }, headers: {
        "Authorization": "Bearer $token"
      });
      handleError(res);
      return right(
          const AppSuccessModel(body: "Successfully created a favorite"));
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, AppSuccessModel>> deleteOne({
    required String businessId,
  }) async {
    try {
      final secureStorage = Get.find<AuthProvider>().secureStorage;
      final token = await secureStorage.read(key: "jwtToken");
      final res = await delete(
        "/$businessId",
        headers: {"Authorization": "Bearer $token"},
      );
      handleError(res);
      return right(
        const AppSuccessModel(body: "Successfully removed from favorites"),
      );
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }
}
