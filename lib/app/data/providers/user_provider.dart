import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:business_dir/app/data/models/app_success_model.dart';
import 'package:business_dir/app/data/models/user_model.dart';
import 'package:business_dir/app/data/providers/auth_provider.dart';
import 'package:business_dir/utils/error_handler.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

class UserProvider extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    // httpClient.baseUrl = 'http://10.0.2.2:8000/api/v1/users';
    httpClient.baseUrl =
        "https://businessdirectory-vnct9q98.b4a.run/api/v1/users";
    httpClient.timeout = const Duration(seconds: 60);
  }

  Future<Either<AppErrorModel, List<UserModel>>> findAll({
    Map<String, dynamic>? query,
  }) async {
    try {
      final token =
          await Get.find<AuthProvider>().secureStorage.read(key: "jwtToken");
      final res = await get(
        "/",
        query: query,
        headers: {"Authorization": "Bearer $token"},
      );
      handleError(res);
      final users = List<UserModel>.from(
        res.body['data'].map(
          (user) => UserModel.fromJson(user),
        ),
      );
      return right(users);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, AppSuccessModel>> deleteOne({
    required String userId,
  }) async {
    try {
      final token =
          await Get.find<AuthProvider>().secureStorage.read(key: "jwtToken");
      final res = await delete(
        "/$userId",
        headers: {"Authorization": "Bearer $token"},
      );
      handleError(res);
      return right(const AppSuccessModel(body: "User delete successfully"));
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, UserModel>> updateOne({
    required Map<String, dynamic> userData,
    required String userId,
  }) async {
    try {
      final token =
          await Get.find<AuthProvider>().secureStorage.read(key: "jwtToken");
      final formData = FormData({
        "email": userData['email'],
        "username": userData['username'],
        "firstName": userData['firstName'],
        "lastName": userData['lastName'],
        "isSuspended": userData['isSuspended'] ?? false,
        "profile_image": userData['profile_image'] != null
            ? MultipartFile(
                userData['profile_image'].readAsBytesSync(),
                filename: userData['profile_image'].path.split('/').last,
              )
            : null,
      });
      final res = await patch(
        "/$userId",
        formData,
        headers: {"Authorization": "Bearer $token"},
      );
      handleError(res);

      final UserModel user = UserModel.fromJson(res.body['data']);
      return right(user);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }
}
