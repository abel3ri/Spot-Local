import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:business_dir/app/data/models/business_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

class BusinessProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://10.0.2.2:8000/api/v1/businesses';
  }

  Future<Either<AppErrorModel, List<BusinessModel>>> fetchBusinesses() async {
    try {
      final res = await get("/");

      final List<BusinessModel> businesses = List.from(
        res.body['data'].map((business) {
          return BusinessModel.fromJson(business);
        }),
      );
      return right(businesses);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, BusinessModel>> createBusiness({
    required BusinessModel business,
  }) async {
    try {
      final res = await post("/", business.toJson());
      return right(BusinessModel.fromJson(res.body));
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, BusinessModel>> fetchBusiness({
    required String id,
  }) async {
    try {
      final res = await get("/", query: {"id": id});
      final BusinessModel business = BusinessModel.fromJson(res.body);
      return right(business);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }
}
