import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:business_dir/app/data/models/user_model.dart';
import 'package:business_dir/app/data/providers/auth_provider.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

class UserProvider extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = 'http://10.0.2.2:8000/api/v1/users';
    // httpClient.baseUrl = "http://192.168.22.202:8000/api/v1";
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
        "image": userData['image'] != null
            ? MultipartFile(
                userData['image'].readAsBytesSync(),
                filename: userData['image'].path.split('/').last,
              )
            : null,
      });
      final res = await patch(
        "/update-account",
        formData,
        headers: {"Authorization": "Bearer $token"},
      );
      if (res.statusCode == 429) {
        throw res.bodyString ?? "Connection problem";
      }
      if (res.hasError) {
        if (res.body == null) throw "Something went wrong";
        throw res.body['message'];
      }

      final UserModel user = UserModel.fromJson(res.body['data']);
      return right(user);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }
}
