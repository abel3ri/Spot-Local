import 'package:business_dir/app/data/models/business_model.dart';
import 'package:business_dir/app/data/providers/business_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ManageBusinessesController extends GetxController {
  PagingController<int, BusinessModel> pagingController =
      PagingController(firstPageKey: 1);
  late BusinessProvider businessProvider;
  Rx<bool> isLoading = false.obs;
  Rx<String> filterBy = "all".obs;
  TextEditingController searchController = TextEditingController();
  final limit = 10;

  Future<void> fetchBusinesses(int pageKey) async {
    final res = await businessProvider.findAll(query: {
      "limit": limit.toString(),
      "page": pageKey.toString(),
      "q": searchController.text,
      parseQuery(): true.toString(),
    });
    res.fold(
      (l) {
        l.showError();
        pagingController.error = l.body;
      },
      (r) {
        final isLastPage = r.length < limit;
        if (isLastPage) {
          pagingController.appendLastPage(r);
        } else {
          int nextPageKey = pageKey + 1;
          pagingController.appendPage(r, nextPageKey);
        }
      },
    );
  }

  Future<void> updateSuspendStatus(
      {required String businessId, required bool suspend}) async {
    isLoading(true);
    final res =
        await businessProvider.updateOne(businessId: businessId, businessData: {
      "isSuspended": suspend,
    });
    isLoading(false);

    res.fold((l) {
      l.showError();
    }, (r) {
      pagingController.refresh();
    });
  }

  Future<void> deleteBusiness({required String businessId}) async {
    isLoading(true);
    final res = await businessProvider.deleteOne(businessId: businessId);
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) {
      pagingController.refresh();
    });
  }

  @override
  void onInit() {
    super.onInit();
    businessProvider = Get.find<BusinessProvider>();
    pagingController.addPageRequestListener(
      (pageKey) => fetchBusinesses(pageKey),
    );
  }

  String parseQuery() {
    String filter_by;
    if (filterBy.value == 'suspended')
      filter_by = "isSuspended";
    else if (filterBy.value == "verified")
      filter_by = "isVerified";
    else
      filter_by = "";

    return filter_by;
  }

  @override
  void onClose() {
    super.onClose();
    pagingController.dispose();
    searchController.dispose();
  }
}
