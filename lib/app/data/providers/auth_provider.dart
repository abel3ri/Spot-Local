import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:business_dir/app/data/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

class AuthProvider extends GetConnect {
  Rx<User?> currentUser = Rx<User?>(null);
  late FlutterSecureStorage secureStorage;
  @override
  void onInit() {
    secureStorage = const FlutterSecureStorage();
    httpClient.baseUrl = 'http://10.0.2.2:8000/api/v1/auth';
  }

  Future<Either<AppErrorModel, void>> signupUser({
    required Map<String, dynamic> userData,
  }) async {
    try {
      final response = await post("/signup", userData);
      await secureStorage.write(key: "jwtToken", value: response.body['token']);
      currentUser.value = User.fromJson(response.body['user']);
      return right(null);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, void>> loginUser(
      {required Map<String, dynamic> userData}) async {
    try {
      final response = await post("/login", userData);
      await secureStorage.write(key: "jwtToken", value: response.body['token']);
      currentUser.value = User.fromJson(response.body['user']);
      return right(null);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, void>> logout() async {
    try {
      currentUser.value = null;
      await secureStorage.delete(
        key: "jwtToken",
      );
      return right(null);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, void>> getUserData() async {
    try {
      final token = await secureStorage.read(key: "jwtToken");
      final response = await get("/users/profile",
          headers: {"Authorization": "Bearer $token"});
      currentUser.value = User.fromJson(response.body['data']);
      return right(null);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }
}
