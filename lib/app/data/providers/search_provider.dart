import 'dart:async';

import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:business_dir/app/data/models/business_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

class SearchProvider extends GetConnect {
  Timer? _debounce;
  Rx<List<BusinessModel>> searchResults = Rx<List<BusinessModel>>([]);
  List<BusinessModel>? results;

  onInit() {
    super.onInit();
  }

  Future<Either<AppErrorModel, List<BusinessModel>>> searchBusinesses({
    required String query,
  }) async {
    try {
      if (_debounce?.isActive ?? false) {
        _debounce?.cancel();
      }

      _debounce = Timer(
        const Duration(milliseconds: 500),
        () async {
          try {
            final res = await get("/businesses/search?q=$query");
            results = List.from(res.body['data']).map((business) {
              return BusinessModel.fromJson(business);
            }).toList();
            if (query.isEmpty) {
              results = [];
            }
          } catch (e) {
            throw e.toString();
          }
        },
      );
      return right(results!);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }
}
