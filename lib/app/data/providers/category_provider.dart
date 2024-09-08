import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:business_dir/app/data/models/category_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

class CategoryProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://10.0.2.2:8000/api/v1/categories';
  }

  Future<Either<AppErrorModel, List<CategoryModel>>> fetchCategories() async {
    try {
      final res = await get("/");
      final List<CategoryModel> categories = List.from(
        res.body.map(
          (category) => CategoryModel.fromJson(category),
        ),
      );
      return right(categories);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, CategoryModel>> createCategory({
    required CategoryModel category,
  }) async {
    try {
      final res = await post("/", category.toJson());
      return right(CategoryModel.fromJson(res.body));
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, CategoryModel>> fetchCategory({
    required String id,
  }) async {
    try {
      final res = await get("/", query: {"id": id});
      final CategoryModel category = CategoryModel.fromJson(res.body);
      return right(category);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }
}
