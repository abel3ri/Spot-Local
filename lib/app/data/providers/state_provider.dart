import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:business_dir/app/data/models/app_success_model.dart';
import 'package:business_dir/app/data/models/state_model.dart';
import 'package:business_dir/app/data/providers/auth_provider.dart';
import 'package:business_dir/utils/error_handler.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

class StateProvider extends GetConnect {
  @override
  void onInit() {
    // httpClient.baseUrl = 'http://10.0.2.2:8000/api/v1/states';
    httpClient.baseUrl =
        "https://businessdirectory-vnct9q98.b4a.run/api/v1/states";
    httpClient.timeout = const Duration(seconds: 60);
  }

  Future<Either<AppErrorModel, List<StateModel>>> findAll({
    Map<String, dynamic>? query,
  }) async {
    try {
      final res = await get("/");
      handleError(res);
      final states = List<StateModel>.from(
        res.body['data'].map(
          (state) => StateModel.fromJson(state),
        ),
      );
      return right(states);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, StateModel>> create({
    required Map<String, dynamic> stateData,
  }) async {
    try {
      final token =
          await Get.find<AuthProvider>().secureStorage.read(key: "jwtToken");
      final res = await post(
        "/",
        stateData,
        headers: {"Authorization": "Bearer $token"},
      );

      handleError(res);
      return right(StateModel.fromJson(res.body['data']));
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, StateModel>> updateOne({
    required String stateId,
    required Map<String, dynamic> stateData,
  }) async {
    try {
      final token = await Get.find<AuthProvider>().secureStorage.read(
            key: "jwtToken",
          );
      final res = await patch(
        "/$stateId",
        stateData,
        headers: {"Authorization": "Bearer $token"},
      );
      handleError(res);
      final state = StateModel.fromJson(res.body['data']);
      return right(state);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, AppSuccessModel>> deleteOne({
    required String stateId,
  }) async {
    try {
      final token =
          await Get.find<AuthProvider>().secureStorage.read(key: "jwtToken");
      final res = await delete(
        "/$stateId",
        headers: {"Authorization": "Bearer $token"},
      );
      handleError(res);
      return right(
          const AppSuccessModel(body: "Successfully deleted the state!"));
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }
}
