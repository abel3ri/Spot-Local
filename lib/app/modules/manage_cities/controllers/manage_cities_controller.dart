import 'package:business_dir/app/data/models/city_model.dart';
import 'package:business_dir/app/data/models/state_model.dart';
import 'package:business_dir/app/data/providers/city_provider.dart';
import 'package:business_dir/app/data/providers/state_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ManageCitiesController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  PagingController<int, CityModel> pagingController =
      PagingController(firstPageKey: 1);
  Rx<CityModel?> selectedCity = Rx<CityModel?>(null);
  final formKey = GlobalKey<FormState>();
  Rx<List<StateModel>> states = Rx<List<StateModel>>([]);
  late CityProvider cityProvider;
  final limit = 10;
  Rx<bool> isLoading = false.obs;
  Rx<StateModel?> selectedState = Rx<StateModel?>(null);

  Future<void> fetchCities(int pageKey) async {
    final res = await cityProvider.findAll(query: {
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

  Future<void> updateCity() async {
    isLoading(true);
    final res = await cityProvider.updateOne(
      cityId: selectedCity.value!.id!,
      cityData: {
        "name": textEditingController.text,
        "stateId": selectedState.value!.id!,
      },
    );
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) {
      clearForm();
      Get.back();
      pagingController.refresh();
    });
  }

  Future<void> createCity() async {
    isLoading(true);
    final res = await cityProvider.create(
      cityData: {
        "name": textEditingController.text,
        "stateId": selectedState.value!.id!,
      },
    );
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) {
      clearForm();
      Get.back();
      pagingController.refresh();
    });
  }

  Future<void> deleteCity({required String cityId}) async {
    isLoading(true);
    final res = await cityProvider.deleteOne(cityId: cityId);
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) {
      pagingController.refresh();
    });
  }

  void setSelectedCity(CityModel city) {
    textEditingController.text = city.name!;
    selectedCity.value = city;
  }

  Future<void> fetchStates() async {
    final stateProvider = Get.put<StateProvider>(StateProvider());
    isLoading(true);
    final res = await stateProvider.findAll();
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) {
      states.value = r;
    });
  }

  @override
  void onInit() {
    cityProvider = Get.find<CityProvider>();
    pagingController.addPageRequestListener((pageKey) {
      fetchCities(pageKey);
    });
    super.onInit();
  }

  void clearForm() {
    selectedCity.value = null;
    selectedState.value = null;
    textEditingController.clear();
  }

  @override
  void onClose() {
    pagingController.dispose();
    textEditingController.dispose();
    super.onClose();
  }
}
