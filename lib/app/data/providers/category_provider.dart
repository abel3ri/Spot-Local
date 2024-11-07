import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:business_dir/app/data/models/app_success_model.dart';
import 'package:business_dir/app/data/models/business_model.dart';
import 'package:business_dir/app/data/models/category_model.dart';
import 'package:business_dir/app/data/providers/auth_provider.dart';
import 'package:business_dir/utils/error_handler.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

class CategoryProvider extends GetConnect {
  @override
  void onInit() {
    // httpClient.baseUrl = 'http://10.0.2.2:8000/api/v1/categories';
    httpClient.baseUrl =
        "https://businessdirectory-vnct9q98.b4a.run/api/v1/categories";
    httpClient.timeout = const Duration(seconds: 60);
  }

  Future<Either<AppErrorModel, List<CategoryModel>>> findAll() async {
    try {
      final res = await get("/");
      handleError(res);
      final List<CategoryModel> categories = List.from(
        res.body['data'].map(
          (category) {
            return CategoryModel.fromJson(category);
          },
        ),
      );
      return right(categories);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, CategoryModel>> create({
    required Map<String, dynamic> categoryData,
  }) async {
    final token =
        await Get.find<AuthProvider>().secureStorage.read(key: "jwtToken");
    try {
      final res = await post(
        "/",
        categoryData,
        headers: {"Authorization": "Bearer $token"},
      );
      handleError(res);
      final category = CategoryModel.fromJson(res.body['data']);
      return right(category);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, AppSuccessModel>> deleteOne({
    required String categoryId,
  }) async {
    try {
      final token =
          await Get.find<AuthProvider>().secureStorage.read(key: "jwtToken");
      final res = await delete(
        "/$categoryId",
        headers: {"Authorization": "Bearer $token"},
      );
      handleError(res);
      return right(
          const AppSuccessModel(body: "Successfully deleted a category"));
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, CategoryModel>> updateOne({
    required String categoryId,
    required Map<String, dynamic> categoryData,
  }) async {
    try {
      final token =
          await Get.find<AuthProvider>().secureStorage.read(key: "jwtToken");
      final res = await patch(
        "/$categoryId",
        categoryData,
        headers: {"Authorization": "Bearer $token"},
      );
      handleError(res);
      final category = CategoryModel.fromJson(res.body['data']);
      return right(category);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, List<BusinessModel>>> findAllBusinessOfCategory({
    required String id,
    Map<String, dynamic>? query,
  }) async {
    try {
      final token =
          await Get.find<AuthProvider>().secureStorage.read(key: "jwtToken");
      final res = await get(
        "/$id/businesses",
        query: query,
        headers: {"Authorization": "Bearer $token"},
      );
      handleError(res);

      final List<BusinessModel> businesses = List.from(
        res.body['data'].map((business) {
          return BusinessModel.fromJson(business);
        }),
      );

      return right(businesses);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }
}
