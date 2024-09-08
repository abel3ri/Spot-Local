import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:business_dir/app/data/models/state_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

class StateProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://10.0.2.2:8000/api/v1/states';
  }

  Future<Either<AppErrorModel, List<StateModel>>> fetchStates() async {
    try {
      final res = await get("/");
      final List<StateModel> states = List.from(
        res.body.map(
          (state) => StateModel.fromJson(state),
        ),
      );
      return right(states);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, StateModel>> creatState({
    required StateModel state,
  }) async {
    try {
      final res = await post("/", state.toJson());
      return right(StateModel.fromJson(res.body));
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, StateModel>> fetchState({
    required String id,
  }) async {
    try {
      final res = await get("/", query: {"id": id});
      final StateModel state = StateModel.fromJson(res.body);
      return right(state);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }
}
