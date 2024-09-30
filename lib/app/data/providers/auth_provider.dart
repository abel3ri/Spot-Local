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
    // httpClient.baseUrl = 'http://10.0.2.2:8000/api/v1';
    httpClient.baseUrl = "http://192.168.22.202:8000/api/v1";
  }

  Future<Either<AppErrorModel, UserModel>> signup({
    required Map<String, dynamic> userData,
  }) async {
    try {
      final res = await post("/auth/signup", userData);
      if (res.hasError) {
        throw res.body['message'] ?? "Connection problem";
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
      print(httpClient.baseUrl);
      final res = await post("/auth/login", userData);
      if (res.hasError) {
        throw res.body['message'] ?? "Connection problem";
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
      if (res.hasError) throw res.body['message'] ?? "Connection problem";
      UserModel user = UserModel.fromJson(res.body['data']);
      return right(user);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }
}
