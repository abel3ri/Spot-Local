import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:business_dir/app/data/models/app_success_model.dart';
import 'package:business_dir/app/data/models/review_model.dart';
import 'package:business_dir/app/data/providers/auth_provider.dart';
import 'package:business_dir/utils/error_handler.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

class ReviewProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = "https://businessdirectory-vnct9q98.b4a.run/api/v1";
    httpClient.timeout = const Duration(seconds: 60);
    // httpClient.baseUrl = 'http://10.0.2.2:8000/api/v1';
  }

  Future<Either<AppErrorModel, List<ReviewModel>>> findAll(
      {required String businessId}) async {
    try {
      final res = await get("/businesses/$businessId/ratings");
      handleError(res);

      List<ReviewModel> ratings = List.from(res.body['data'])
          .map((rating) => ReviewModel.fromJson(rating))
          .toList();
      return right(ratings);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, ReviewModel>> create(
      {required Map<String, dynamic> ratingData}) async {
    try {
      final secureStorage = Get.find<AuthProvider>().secureStorage;
      final token = await secureStorage.read(key: "jwtToken");
      if (token == null || token.isEmpty) {
        return left(const AppErrorModel(body: "User not found!"));
      }
      final res = await post(
        "/ratings",
        ratingData,
        headers: {"Authorization": "Bearer $token"},
      );

      handleError(res);
      final rating = ReviewModel.fromJson(res.body['data']);
      return right(rating);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, ReviewModel>> updateOne({
    required Map<String, dynamic> ratingData,
    required String reviewId,
  }) async {
    try {
      final secureStorage = Get.find<AuthProvider>().secureStorage;
      final token = await secureStorage.read(key: "jwtToken");
      if (token == null || token.isEmpty) {
        return left(const AppErrorModel(body: "User not found!"));
      }

      final res = await patch(
        "/ratings/$reviewId",
        ratingData,
        headers: {"Authorization": "Bearer $token"},
      );

      handleError(res);
      final rating = ReviewModel.fromJson(res.body['data']);
      return right(rating);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, AppSuccessModel>> deleteOne({
    required String reviewId,
  }) async {
    try {
      final secureStorage = Get.find<AuthProvider>().secureStorage;
      final token = await secureStorage.read(key: "jwtToken");
      if (token == null || token.isEmpty) {
        return left(const AppErrorModel(body: "User not found!"));
      }

      final res = await delete(
        "/ratings/$reviewId",
        headers: {"Authorization": "Bearer $token"},
      );

      handleError(res);
      return right(
          const AppSuccessModel(body: "Successfully deleted a rating!"));
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }
}
