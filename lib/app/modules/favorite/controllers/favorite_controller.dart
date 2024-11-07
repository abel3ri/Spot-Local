import 'package:business_dir/app/data/models/favorite_model.dart';
import 'package:business_dir/app/data/providers/favorite_provider.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class FavoriteController extends GetxController {
  late FavoriteProvider favoriteProvider;
  PagingController<int, FavoriteModel> pagingController = PagingController(
    firstPageKey: 1,
  );
  final int limit = 10;

  @override
  void onInit() {
    favoriteProvider = Get.put<FavoriteProvider>(FavoriteProvider());
    pagingController.addPageRequestListener((pageKey) {
      fetchAllFavorites(pageKey);
    });
    super.onInit();
  }

  Future<void> fetchAllFavorites(int pageKey) async {
    final res = await favoriteProvider.findAll(query: {
      "limit": limit.toString(),
      "page": pageKey.toString(),
    });
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

  Future<void> deleteFavorite({
    required String businessId,
  }) async {
    final res = await favoriteProvider.deleteOne(businessId: businessId);
    res.fold((l) {
      l.showError();
    }, (r) {
      pagingController.refresh();
    });
  }

  Future<void> create({
    required String businessId,
  }) async {
    final res = await favoriteProvider.create(businessId: businessId);
    res.fold((l) {
      l.showError();
    }, (r) {
      pagingController.refresh();
    });
  }

  @override
  void onClose() {
    pagingController.dispose();

    super.onClose();
  }
}
