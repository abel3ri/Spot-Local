import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:business_dir/app/data/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

class AuthProvider extends GetConnect {
  late FlutterSecureStorage secureStorage;
  @override
  void onInit() {
    secureStorage = const FlutterSecureStorage();
    httpClient.baseUrl = 'http://10.0.2.2:8000/api/v1/auth';
  }

  Future<Either<AppErrorModel, UserModel>> signupUser({
    required Map<String, dynamic> userData,
  }) async {
    try {
      final res = await post("/signup", userData);
      await secureStorage.write(key: "jwtToken", value: res.body['token']);
      final UserModel user = UserModel.fromJson(res.body['user']);
      return right(user);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, UserModel>> loginUser(
      {required Map<String, dynamic> userData}) async {
    try {
      final res = await post("/login", userData);
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
        return left(const AppErrorModel(body: "user not found"));
      }
      final res = await get("/users/profile",
          headers: {"Authorization": "Bearer $token"});
      UserModel user = UserModel.fromJson(res.body['data']);
      return right(user);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }
}
