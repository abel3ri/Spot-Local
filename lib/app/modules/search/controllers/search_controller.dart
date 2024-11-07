import 'dart:async';

import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:business_dir/app/data/models/business_model.dart';
import 'package:business_dir/app/data/providers/auth_provider.dart';
import 'package:business_dir/utils/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

class SearchController extends GetConnect {
  TextEditingController searchInputController = TextEditingController();
  Timer? _debounce;
  Rx<List<BusinessModel>> searchResults = Rx<List<BusinessModel>>([]);
  Rx<bool> isLoading = false.obs;
  Rx<bool> animateSearchLottie = true.obs;

  @override
  onInit() {
    super.onInit();
    httpClient.baseUrl = "https://businessdirectory-vnct9q98.b4a.run/api/v1";
    // httpClient.baseUrl = 'http://10.0.2.2:8000/api/v1';
  }

  Future<Either<AppErrorModel, void>> searchBusiness({
    required String query,
  }) async {
    try {
      final token =
          await Get.find<AuthProvider>().secureStorage.read(key: "jwtToken");
      if (query.isEmpty) {
        return right(null);
      }

      if (_debounce?.isActive ?? false) {
        _debounce?.cancel();
      }

      _debounce = Timer(Duration(milliseconds: 500), () async {
        try {
          isLoading.value = true;
          final res = await get(
            "/businesses/search?q=$query",
            headers: {"Authorization": "Bearer $token"},
          );

          handleError(res);

          searchResults.value = List.from(res.body['data']).map((business) {
            return BusinessModel.fromJson(business);
          }).toList();

          if (query.isEmpty) {
            searchResults.value = [];
          }
        } catch (e) {
          print("Error during search: $e");
        } finally {
          isLoading.value = false;
        }
      });

      return right(null);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _debounce?.cancel();
    searchInputController.dispose();
    super.onClose();
  }
}
