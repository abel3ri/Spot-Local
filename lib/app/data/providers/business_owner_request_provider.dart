import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:business_dir/app/data/models/app_success_model.dart';
import 'package:business_dir/app/data/models/business_owner_request_model.dart';
import 'package:business_dir/app/data/providers/auth_provider.dart';
import 'package:business_dir/utils/error_handler.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

class BusinessOwnerRequestProvider extends GetConnect {
  @override
  void onInit() {
    // httpClient.baseUrl = 'http://10.0.2.2:8000/api/v1/business-owner-requests';
    httpClient.baseUrl =
        "https://businessdirectory-vnct9q98.b4a.run/api/v1/business-owner-requests";
        httpClient.timeout = const Duration(seconds: 60);
  }

  Future<Either<AppErrorModel, List<BusinessOwnerRequestModel>>> findAll(
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
      final businessOwnerRequests = List<BusinessOwnerRequestModel>.from(
        res.body['data'].map(
          (request) => BusinessOwnerRequestModel.fromJson(request),
        ),
      );
      return right(businessOwnerRequests);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, AppSuccessModel>> updateOne({
    required String requestId,
    required Map<String, dynamic> requestData,
  }) async {
    try {
      final token =
          await Get.find<AuthProvider>().secureStorage.read(key: "jwtToken");
      final res = await patch("/$requestId", requestData,
          headers: {"Authorization": "Bearer $token"});
      handleError(res);

      return right(AppSuccessModel(body: res.body['message']));
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }
}
