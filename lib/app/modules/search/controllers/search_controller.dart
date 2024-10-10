import 'dart:async';

import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:business_dir/app/data/models/business_model.dart';
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
    // httpClient.baseUrl = "http://192.168.22.202:8000/api/v1";
    httpClient.baseUrl = 'http://10.0.2.2:8000/api/v1';
  }

  Future<Either<AppErrorModel, void>> searchBusiness({
    required String query,
  }) async {
    try {
      if (_debounce?.isActive ?? false) {
        _debounce?.cancel();
      }

      _debounce = Timer(Duration(milliseconds: 500), () async {
        try {
          isLoading.value = true;
          final res = await get("/businesses/search?q=${query}");
          if (res.hasError) {
            throw "Unknown Error";
          }
          searchResults.value = List.from(res.body['data']).map((business) {
            return BusinessModel.fromJson(business);
          }).toList();
          if (query.isEmpty) {
            searchResults.value = [];
          }
          isLoading.value = false;
        } catch (e) {
          throw e.toString();
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
    searchInputController.dispose();
    super.onClose();
  }
}
