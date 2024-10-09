import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:business_dir/app/data/models/business_model.dart';
import 'package:business_dir/app/data/models/business_performance_model.dart';
import 'package:business_dir/app/data/providers/auth_provider.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

class BusinessProvider extends GetConnect {
  @override
  void onInit() {
    // httpClient.baseUrl = 'http://10.0.2.2:8000/api/v1/businesses';
    httpClient.baseUrl = "http://192.168.22.202:8000/api/v1/businesses";
  }

  Future<Either<AppErrorModel, List<BusinessModel>>> findAll() async {
    try {
      final res = await get("/");
      if (res.hasError) {
        if (res.body == null) throw "Something went wrong";
        throw res.body['message'];
      }
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

  Future<Either<AppErrorModel, BusinessModel>> create({
    required BusinessModel business,
  }) async {
    try {
      final res = await post("/", business.toJson());
      if (res.hasError) {
        if (res.body == null) throw "Something went wrong";
        throw res.body['message'];
      }
      return right(BusinessModel.fromJson(res.body));
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, BusinessModel>> findOne({
    required String id,
  }) async {
    try {
      final res = await get("/", query: {"id": id});
      if (res.hasError) {
        if (res.body == null) throw "Something went wrong";
        throw res.body['message'];
      }
      final BusinessModel business = BusinessModel.fromJson(res.body);
      return right(business);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, BusinessPerformanceModel>>
      getBusinessPerformance({required String businessId}) async {
    try {
      final res = await get("/${businessId}/performance");
      if (res.hasError) {
        if (res.body == null) throw "Something went wrong";
        throw res.body['message'];
      }
      final businessPerformance = BusinessPerformanceModel.fromJson(
        res.body['data'],
      );
      return right(businessPerformance);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, List<BusinessModel>>> getMyBusinesses() async {
    try {
      final token =
          await Get.find<AuthProvider>().secureStorage.read(key: "jwtToken");
      if (token == null) {
        throw "No user found!";
      }
      final res = await get(
        "/my-businesses",
        headers: {"Authorization": "Bearer $token"},
      );
      if (res.hasError) {
        if (res.body == null) throw "Something went wrong";
        throw res.body['message'];
      }

      final businesses = List<BusinessModel>.from(
        res.body['data'].map(
          (business) {
            return BusinessModel.fromJson(business);
          },
        ).toList(),
      );
      return right(businesses);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }
}
