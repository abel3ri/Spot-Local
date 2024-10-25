import 'package:business_dir/app/data/models/business_owner_request_model.dart';
import 'package:business_dir/app/data/providers/business_owner_request_provider.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ManageRequestsController extends GetxController {
  Rx<bool> isLoading = false.obs;
  Rx<String> filterBy = "all".obs;
  late BusinessOwnerRequestProvider businessOwnerRequestProvider;
  PagingController<int, BusinessOwnerRequestModel> pagingController =
      PagingController(firstPageKey: 1);

  final int limit = 10;

  @override
  void onInit() {
    businessOwnerRequestProvider = Get.find<BusinessOwnerRequestProvider>();
    pagingController.addPageRequestListener((pageKey) {
      fetchRequests(pageKey: pageKey);
    });
    super.onInit();
  }

  Future<void> fetchRequests({int pageKey = 1}) async {
    final res = await businessOwnerRequestProvider.findAll(
      query: {
        "filter": filterBy.value,
        "limit": limit.toString(),
        "page": pageKey.toString(),
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
        int nextPageKey = pageKey + 1;
        pagingController.appendPage(r, nextPageKey);
      }
    });
  }

  Future<void> updateRequest({
    required String requestId,
    required Map<String, dynamic> requestData,
  }) async {
    isLoading(true);
    final res = await businessOwnerRequestProvider.updateOne(
      requestId: requestId,
      requestData: requestData,
    );
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) {
      r.showSuccess();
      pagingController.refresh();
    });
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
