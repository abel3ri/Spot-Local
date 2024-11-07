import 'package:business_dir/app/data/models/business_model.dart';
import 'package:business_dir/app/data/models/business_owner_request_model.dart';
import 'package:business_dir/app/data/providers/business_provider.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MyBusinessesController extends GetxController {
  Rx<bool> isLoading = false.obs;
  Rx<List<BusinessOwnerRequestModel>> businessesRequests =
      Rx<List<BusinessOwnerRequestModel>>([]);
  late BusinessProvider businessProvider;
  Rx<BusinessModel?> selectedBusiness = Rx<BusinessModel?>(null);
  Rx<BusinessModel?> toBeFeaturedBusiness = Rx<BusinessModel?>(null);

  PagingController<int, BusinessOwnerRequestModel> pagingController =
      PagingController(firstPageKey: 1);
  final int limit = 10;
  @override
  void onInit() {
    super.onInit();
    businessProvider = Get.find<BusinessProvider>();
    pagingController.addPageRequestListener((pageKey) {
      getMyBusinesses(pageKey);
    });
  }

  Future<void> getMyBusinesses(int pageKey) async {
    final res = await businessProvider.getMyBusinesses(query: {
      "limit": limit.toString(),
      "page": pageKey.toString(),
    });
    res.fold((l) {
      l.showError();
      pagingController.error = l.body;
    }, (r) {
      final isLastPage = r.length < limit;
      if (isLastPage) {
        pagingController.appendLastPage(r);
      } else {
        pagingController.appendPage(r, pageKey + 1);
      }
    });
  }
}
