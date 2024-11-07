import 'package:business_dir/app/data/models/featured_model.dart';
import 'package:business_dir/app/data/providers/featured_provider.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ManageFeatureRequestsController extends GetxController {
  Rx<String> filterBy = "all".obs;
  Rx<bool> isLoading = false.obs;
  late FeaturedProvider featuredProvider;
  PagingController<int, FeaturedModel> pagingController = PagingController(
    firstPageKey: 1,
  );
  final int limit = 10;
  @override
  void onInit() {
    super.onInit();
    featuredProvider = Get.find<FeaturedProvider>();
    pagingController.addPageRequestListener((pageKey) {
      getAllFeaturedRequests(pageKey);
    });
  }

  Future<void> getAllFeaturedRequests(int pageKey) async {
    final res = await featuredProvider.findAll(query: {
      "limit": limit.toString(),
      "page": pageKey.toString(),
      "status": filterBy.value,
    });
    res.fold((l) {
      l.showError();
      pagingController.error = l.body;
    }, (r) {
      final bool isLastPage = r.length < limit;
      if (isLastPage) {
        pagingController.appendLastPage(r);
      } else {
        pagingController.appendPage(r, pageKey + 1);
      }
    });
  }

  Future<void> updateFeatured({
    required String featuredId,
    required String status,
  }) async {
    isLoading(true);
    final res = await featuredProvider.updateOne(
        featuredId: featuredId, status: status);
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) async {
      pagingController.refresh();
    });
  }
}
