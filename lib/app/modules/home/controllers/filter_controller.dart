import 'package:business_dir/app/data/models/business_model.dart';
import 'package:business_dir/app/data/models/city_model.dart';
import 'package:business_dir/app/data/models/state_model.dart';
import 'package:business_dir/app/data/providers/business_provider.dart';
import 'package:business_dir/app/data/providers/city_provider.dart';
import 'package:business_dir/app/data/providers/state_provider.dart';
import 'package:business_dir/app/modules/home/controllers/home_controller.dart';
import 'package:business_dir/app/modules/home/views/filtered_business_view.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  var selectedFilters = <String>[].obs;
  Rx<List<StateModel>> states = Rx<List<StateModel>>([]);
  Rx<List<CityModel>> cities = Rx<List<CityModel>>([]);
  Rx<List<BusinessModel>> businesses = Rx<List<BusinessModel>>([]);

  Rx<StateModel?> selectedState = Rx<StateModel?>(null);
  Rx<CityModel?> selectedCity = Rx<CityModel?>(null);

  Rx<bool> isStatesLoading = false.obs;
  Rx<bool> isCitiesLoading = false.obs;
  Rx<bool> isBusinessLoading = false.obs;

  @override
  void onInit() {
    Get.lazyPut(() => StateProvider());
    Get.lazyPut(() => CityProvider());
    Get.lazyPut(() => BusinessProvider());
    getAllStates();
    super.onInit();
  }

  Future<void> getAllStates() async {
    final stateProvider = Get.find<StateProvider>();
    isStatesLoading(true);
    final res = await stateProvider.findAll();
    isStatesLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) {
      states.value = r;
    });
  }

  Future<void> getAllCities(String stateId) async {
    final cityProvider = Get.find<CityProvider>();
    isCitiesLoading(true);
    final res = await cityProvider.findAll(
      query: {
        "stateId": stateId,
      },
    );
    isCitiesLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) {
      cities.value = r;
    });
  }

  Future<void> fetchBusinesses() async {
    final businessProvider = Get.find<BusinessProvider>();
    final allCategories = Get.find<HomeController>().categories.value.map(
          (category) => category.name,
        );
    Map<String, dynamic> query = {};
    if (selectedFilters.contains("Featured")) {
      query['featured'] = true.toString();
    }
    if (selectedFilters.contains("Unverified")) {
      query['isVerified'] = false.toString();
    }

    final List<String> selectedCategories = selectedFilters
        .where((filter) => allCategories.contains(filter))
        .toList();
    if (selectedCategories.isNotEmpty) {
      query['categories'] = selectedCategories.join(',');
    }
    if (selectedCity.value != null) {
      query['city'] = selectedCity.value!.name!;
    }
    if (selectedState.value != null) {
      query['state'] = selectedState.value!.name!;
    }

    isBusinessLoading(true);
    final res = await businessProvider.findAll(query: query);
    isBusinessLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) {
      businesses.value = r;
      Get.to(() => const FilteredBusinessView());
    });
  }

  void selectState(StateModel? state) {
    selectedState.value = state;
    selectedCity.value = null;
    if (state != null) {
      getAllCities(state.id!);
    }
  }

  void selectCity(CityModel? city) {
    selectedCity.value = city;
  }

  void toggleFilter(String label) {
    if (selectedFilters.contains(label)) {
      selectedFilters.remove(label);
    } else {
      selectedFilters.add(label);
    }
  }

  bool isSelected(String label) {
    return selectedFilters.contains(label);
  }

  @override
  void onClose() {
    Get.delete<CityProvider>();
    Get.delete<StateProvider>();
    super.onClose();
  }
}
