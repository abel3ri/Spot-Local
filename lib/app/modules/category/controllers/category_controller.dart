import 'package:business_dir/app/data/models/business_model.dart';
import 'package:business_dir/app/data/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CategoryController extends GetxController {
  late CategoryProvider categoryProvider;
  PagingController<int, BusinessModel> pagingController =
      PagingController(firstPageKey: 1);
  Rx<String> sortBy = Rx<String>("name_asc");
  final int limit = 10;
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    categoryProvider = Get.find<CategoryProvider>();

    pagingController.addPageRequestListener((pageKey) {
      fetchBusinesses(pageKey);
    });
  }

  Future<void> fetchBusinesses(int pageKey) async {
    final res = await categoryProvider.findAllBusinessOfCategory(
      id: Get.arguments['id'],
      query: {
        "limit": limit.toString(),
        "page": pageKey.toString(),
        "q": searchController.text,
        "isVerified": true.toString(),
      },
    );
    res.fold((l) {
      l.showError();
    }, (r) {
      final bool isLastPage = r.length < limit;
      if (isLastPage) {
        pagingController.appendLastPage(r);
      } else {
        pagingController.appendPage(r, pageKey + 1);
      }
    });
  }

  @override
  void onClose() {
    pagingController.dispose();
    searchController.dispose();
    super.onClose();
  }
}
