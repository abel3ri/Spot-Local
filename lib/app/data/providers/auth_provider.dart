import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:business_dir/app/data/models/app_success_model.dart';
import 'package:business_dir/app/data/models/user_model.dart';
import 'package:business_dir/utils/error_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

class AuthProvider extends GetConnect {
  late FlutterSecureStorage secureStorage;
  @override
  void onInit() {
    secureStorage = const FlutterSecureStorage();
    // httpClient.baseUrl = 'http://10.0.2.2:8000/api/v1';
    httpClient.baseUrl = "https://businessdirectory-vnct9q98.b4a.run/api/v1";
    httpClient.timeout = const Duration(seconds: 60);
  }

  Future<Either<AppErrorModel, UserModel>> signup({
    required Map<String, dynamic> userData,
  }) async {
    try {
      final formData = FormData({
        "email": userData['email'],
        "username": userData['username'],
        "firstName": userData['firstName'],
        "lastName": userData['lastName'],
        "password": userData['password'],
        "confirmPassword": userData['confirmPassword'],
        "profile_image": userData['profile_image'] != null
            ? MultipartFile(
                userData['profile_image'].readAsBytesSync(),
                filename: userData['profile_image'].path.split('/').last,
              )
            : null,
      });
      final res = await post("/auth/signup", formData);
      handleError(res);
      await secureStorage.write(key: "jwtToken", value: res.body['token']);

      final UserModel user = UserModel.fromJson(res.body['user']);
      return right(user);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, UserModel>> login(
      {required Map<String, dynamic> userData}) async {
    try {
      final res = await post("/auth/login", userData);
      handleError(res);
      await secureStorage.write(key: "jwtToken", value: res.body['token']);
      final UserModel user = UserModel.fromJson(res.body['user']);
      return right(user);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, void>> logout() async {
    try {
      await secureStorage.delete(
        key: "jwtToken",
      );
      return right(null);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, UserModel>> getUserData() async {
    try {
      final token = await secureStorage.read(key: "jwtToken");
      if (token == null) {
        throw "No user found!";
      }
      final res = await get("/users/profile",
          headers: {"Authorization": "Bearer $token"});

      handleError(res);
      UserModel user = UserModel.fromJson(res.body['data']);
      return right(user);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, AppSuccessModel>> sendOTP(
      {required String email}) async {
    try {
      final res = await httpClient
          .post("/auth/forgot-password", body: {"email": email});
      handleError(res);
      return right(AppSuccessModel(body: res.body['message']));
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, UserModel>> resetPassword({
    required int otp,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final res = await httpClient.patch("/auth/reset-password", body: {
        "otp": otp,
        "password": password,
        "confirmPassword": confirmPassword,
      });
      handleError(res);
      await secureStorage.write(key: "jwtToken", value: res.body['token']);
      return right(UserModel.fromJson(res.body['data']));
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }
}
