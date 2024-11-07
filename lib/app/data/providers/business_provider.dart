import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:business_dir/app/data/models/app_success_model.dart';
import 'package:business_dir/app/data/models/business_model.dart';
import 'package:business_dir/app/data/models/business_owner_request_model.dart';
import 'package:business_dir/app/data/models/business_performance_model.dart';
import 'package:business_dir/app/data/providers/auth_provider.dart';
import 'package:business_dir/utils/error_handler.dart';

import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

class BusinessProvider extends GetConnect {
  @override
  void onInit() {
    // httpClient.baseUrl = 'http://10.0.2.2:8000/api/v1/businesses';
    httpClient.baseUrl =
        "https://businessdirectory-vnct9q98.b4a.run/api/v1/businesses";
    httpClient.timeout = const Duration(seconds: 120);
  }

  Future<Either<AppErrorModel, List<BusinessModel>>> findAll({
    Map<String, dynamic>? query,
  }) async {
    try {
      final res = await get("/", query: query);
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

  Future<Either<AppErrorModel, BusinessModel>> create({
    required Map<String, dynamic> businessData,
  }) async {
    try {
      FormData formData = FormData({
        "name": businessData['name'],
        "description": businessData['description'],
        "licenseNumber": businessData['licenseNumber'],
        "operationHours": businessData['operationHours'],
        "address": businessData['address'],
        "email": businessData['email'],
        "cityId": businessData['cityId'],
        "business_license": MultipartFile(
          await businessData['business_license'].readAsBytes(),
          filename: businessData['business_license'].path.split('/').last,
        ),
        "business_logo": businessData['business_logo'] != null
            ? MultipartFile(
                await businessData['business_logo'].readAsBytes(),
                filename: businessData['business_logo'].path.split('/').last,
              )
            : null,
      });

      if (businessData['latLng'] != null) {
        for (var latLng in businessData['latLng']) {
          formData.fields.add(MapEntry("latLng", latLng.toString()));
        }
      }

      if (businessData['categories'] != null) {
        for (int i = 0; i < businessData['categories'].length; i++) {
          formData.fields
              .add(MapEntry("categories[$i]", businessData['categories'][i]));
        }
      }
      if (businessData['phone'] != null) {
        for (int i = 0; i < businessData['phone'].length; i++) {
          formData.fields.add(MapEntry("phone[$i]", businessData['phone'][i]));
        }
      }
      if (businessData['socialMedia'] != null) {
        for (int i = 0; i < businessData['socialMedia'].length; i++) {
          formData.fields.add(MapEntry(
            "socialMedia[$i]",
            businessData['socialMedia'][i],
          ));
        }
      }

      if (businessData['business_images'] != null) {
        for (var image in businessData['business_images']) {
          formData.files.add(
            MapEntry(
              "business_images",
              MultipartFile(
                image.readAsBytesSync(),
                filename: image.path.split('/').last,
              ),
            ),
          );
        }
      }

      final token =
          await Get.find<AuthProvider>().secureStorage.read(key: "jwtToken");
      final res = await post("/", formData,
          headers: {"Authorization": "Bearer $token"});
      handleError(res);
      return right(BusinessModel.fromJson(res.body['data']));
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, BusinessModel>> updateOne({
    required String businessId,
    required Map<String, dynamic> businessData,
  }) async {
    try {
      FormData formData = FormData({
        "name": businessData['name'],
        "description": businessData['description'],
        "licenseNumber": businessData['licenseNumber'],
        "operationHours": businessData['operationHours'],
        "address": businessData['address'],
        "email": businessData['email'],
        "cityId": businessData['cityId'],
        "isVerified": businessData['isVerified'],
        "isSuspended": businessData['isSuspended'],
        "business_license": businessData['business_license'] != null
            ? MultipartFile(
                await businessData['business_license'].readAsBytes(),
                filename: businessData['business_license'].path.split('/').last,
              )
            : null,
        "business_logo": businessData['business_logo'] != null
            ? MultipartFile(
                await businessData['business_logo'].readAsBytes(),
                filename: businessData['business_logo'].path.split('/').last,
              )
            : null,
      });

      if (businessData['latLng'] != null) {
        for (var latLng in businessData['latLng']) {
          formData.fields.add(MapEntry("latLng", latLng.toString()));
        }
      }

      if (businessData['categories'] != null) {
        for (int i = 0; i < businessData['categories'].length; i++) {
          formData.fields
              .add(MapEntry("categories[$i]", businessData['categories'][i]));
        }
      }
      if (businessData['phone'] != null) {
        for (int i = 0; i < businessData['phone'].length; i++) {
          formData.fields.add(MapEntry("phone[$i]", businessData['phone'][i]));
        }
      }
      if (businessData['socialMedia'] != null) {
        for (int i = 0; i < businessData['socialMedia'].length; i++) {
          formData.fields
              .add(MapEntry("socialMedia[$i]", businessData['socialMedia'][i]));
        }
      }

      if (businessData['business_images'] != null) {
        for (var image in businessData['business_images']) {
          formData.files.add(
            MapEntry(
              "business_images",
              MultipartFile(
                image.readAsBytesSync(),
                filename: image.path.split('/').last,
              ),
            ),
          );
        }
      }
      final token =
          await Get.find<AuthProvider>().secureStorage.read(key: "jwtToken");
      final res = await patch("/$businessId", formData,
          headers: {"Authorization": "Bearer $token"});
      handleError(res);
      return right(BusinessModel.fromJson(res.body['data']));
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, BusinessModel>> findOne({
    required String id,
  }) async {
    try {
      final res = await get("/", query: {"id": id});
      handleError(res);
      final BusinessModel business = BusinessModel.fromJson(res.body['data']);
      return right(business);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, AppSuccessModel>> deleteOne({
    required String businessId,
  }) async {
    try {
      final token =
          await Get.find<AuthProvider>().secureStorage.read(key: "jwtToken");
      final res = await delete(
        "/$businessId",
        headers: {"Authorization": "Bearer $token"},
      );
      handleError(res);
      return right(
          const AppSuccessModel(body: "Successfully deleted the business"));
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, BusinessPerformanceModel>>
      getBusinessPerformance({required String businessId}) async {
    try {
      final res = await get("/$businessId/performance");
      handleError(res);
      final businessPerformance = BusinessPerformanceModel.fromJson(
        res.body['data'],
      );
      return right(businessPerformance);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, List<BusinessOwnerRequestModel>>>
      getMyBusinesses({
    Map<String, dynamic>? query,
  }) async {
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
      handleError(res);
      final businesses = List<BusinessOwnerRequestModel>.from(
        res.body['data'].map(
          (request) {
            return BusinessOwnerRequestModel.fromJson(request);
          },
        ).toList(),
      );
      return right(businesses);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }
}
