import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:business_dir/app/data/models/app_success_model.dart';
import 'package:business_dir/app/data/models/city_model.dart';
import 'package:business_dir/app/data/providers/auth_provider.dart';
import 'package:business_dir/utils/error_handler.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

class CityProvider extends GetConnect {
  @override
  void onInit() {
    // httpClient.baseUrl = 'http://10.0.2.2:8000/api/v1/cities';
    httpClient.baseUrl =
        "https://businessdirectory-vnct9q98.b4a.run/api/v1/cities";
    httpClient.timeout = const Duration(seconds: 60);
  }

  Future<Either<AppErrorModel, List<CityModel>>> findAll({
    Map<String, dynamic>? query,
  }) async {
    try {
      final res = await get("/", query: query);
      handleError(res);
      final cities = List<CityModel>.from(
        res.body['data'].map(
          (city) => CityModel.fromJson(city),
        ),
      );
      return right(cities);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, CityModel>> create({
    required Map<String, dynamic> cityData,
  }) async {
    try {
      final token =
          await Get.find<AuthProvider>().secureStorage.read(key: "jwtToken");
      final res = await post(
        "/",
        cityData,
        headers: {"Authorization": "Bearer $token"},
      );

      handleError(res);
      return right(CityModel.fromJson(res.body['data']));
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, CityModel>> updateOne({
    required String cityId,
    required Map<String, dynamic> cityData,
  }) async {
    try {
      final token =
          await Get.find<AuthProvider>().secureStorage.read(key: "jwtToken");
      final res = await patch(
        "/$cityId",
        cityData,
        headers: {"Authorization": "Bearer $token"},
      );
      handleError(res);
      final city = CityModel.fromJson(res.body['data']);
      return right(city);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, AppSuccessModel>> deleteOne({
    required String cityId,
  }) async {
    try {
      final token =
          await Get.find<AuthProvider>().secureStorage.read(key: "jwtToken");
      final res = await delete(
        "/$cityId",
        headers: {"Authorization": "Bearer $token"},
      );
      handleError(res);
      return right(
          const AppSuccessModel(body: "Successfully deleted the city!"));
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }
}
