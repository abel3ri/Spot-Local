import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:business_dir/app/data/models/city_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

class CityProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://10.0.2.2:8000/api/v1/cities';
    // httpClient.baseUrl = "http://192.168.22.202:8000/api/v1/cities";
  }

  Future<Either<AppErrorModel, List<CityModel>>> fetchCities() async {
    try {
      final res = await get("/");
      final List<CityModel> cities = List.from(
        res.body.map(
          (city) => CityModel.fromJson(city),
        ),
      );
      return right(cities);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, CityModel>> createCity({
    required CityModel city,
  }) async {
    try {
      final res = await post("/", city.toJson());
      return right(CityModel.fromJson(res.body));
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, CityModel>> fetchCity({
    required String id,
  }) async {
    try {
      final res = await get("/", query: {"id": id});
      final CityModel city = CityModel.fromJson(res.body);
      return right(city);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }
}
