import 'package:business_dir/app/data/models/user_model.dart';
import 'package:business_dir/app/data/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ManageUsersController extends GetxController {
  PagingController<int, UserModel> pagingController =
      PagingController(firstPageKey: 1);
  TextEditingController searchController = TextEditingController();

  late UserProvider userProvider;
  final int limit = 10;

  @override
  void onInit() {
    userProvider = Get.find<UserProvider>();
    pagingController.addPageRequestListener((pageKey) {
      fetchUsers(pageKey);
    });
    super.onInit();
  }

  Future<void> fetchUsers(int pageKey) async {
    final res = await userProvider.findAll(
      query: {
        "limit": limit.toString(),
        "page": pageKey.toString(),
        "q": searchController.text,
      },
    );
    res.fold((l) {
      l.showError();
      pagingController.error = l.body;
    }, (r) {
      bool isLastPage = r.length < limit;
      if (isLastPage) {
        pagingController.appendLastPage(r);
      } else {
        pagingController.appendPage(r, pageKey + 1);
      }
    });
  }

  Future<void> updateSuspendedStatus({
    required String userId,
    required bool isSuspended,
  }) async {
    final res = await userProvider.updateOne(
      userData: {
        "isSuspended": isSuspended.toString(),
      },
      userId: userId,
    );
    res.fold((l) {
      l.showError();
    }, (r) {
      pagingController.refresh();
    });
  }

  Future<void> deleteUser({
    required String userId,
  }) async {
    final res = await userProvider.deleteOne(userId: userId);
    res.fold((l) {
      l.showError();
    }, (r) {
      pagingController.refresh();
    });
  }

  @override
  void onClose() {
    pagingController.dispose();
    searchController.dispose();
    super.onClose();
  }
}
