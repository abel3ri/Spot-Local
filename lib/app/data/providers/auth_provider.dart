import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:business_dir/app/data/models/app_success_model.dart';
import 'package:business_dir/app/data/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

class AuthProvider extends GetConnect {
  late FlutterSecureStorage secureStorage;
  @override
  void onInit() {
    secureStorage = const FlutterSecureStorage();
    httpClient.baseUrl = 'http://10.0.2.2:8000/api/v1';
    // httpClient.baseUrl = "http://192.168.22.202:8000/api/v1";
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
        "image": MultipartFile(
          userData['image'].readAsBytesSync(),
          filename: userData['image'].path.split('/').last,
        ),
      });
      final res = await post("/auth/signup", formData);

      if (res.statusCode == 429) {
        throw res.bodyString ?? "Connection problem";
      }
      if (res.hasError) {
        if (res.body == null) throw "Something went wrong";
        throw res.body['message'];
      }
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

      if (res.statusCode == 429) {
        throw res.bodyString ?? "Connection problem";
      }

      if (res.hasError) {
        if (res.body == null) throw "Something went wrong";
        throw res.body['message'];
      }
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

      if (res.statusCode == 429) {
        throw res.bodyString ?? "Connection problem";
      }
      if (res.hasError) {
        if (res.body == null) throw "Something went wrong";
        throw res.body['message'];
      }
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
      if (res.hasError) {
        if (res.body == null) {
          return left(AppErrorModel(body: "something went wrong"));
        }
        return left(AppErrorModel(body: res.body['message']));
      }
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
      if (res.hasError) {
        if (res.body == null) {
          return left(AppErrorModel(body: "something went wrong"));
        }
        return left(AppErrorModel(body: res.body['message']));
      }
      await secureStorage.write(key: "jwtToken", value: res.body['token']);
      return right(UserModel.fromJson(res.body['data']));
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }
}
