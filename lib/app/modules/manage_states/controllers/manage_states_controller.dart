import 'package:business_dir/app/data/models/state_model.dart';
import 'package:business_dir/app/data/providers/state_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ManageStatesController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  PagingController<int, StateModel> pagingController =
      PagingController(firstPageKey: 1);
  StateModel? selectedState;
  final formKey = GlobalKey<FormState>();
  late StateProvider stateProvider;
  final int limit = 5;
  Rx<bool> isLoading = false.obs;

  Future<void> fetchStates(int pageKey) async {
    final res = await stateProvider.findAll(query: {
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

  Future<void> createState() async {
    isLoading(true);
    final res = await stateProvider.create(
      stateData: {
        "name": textEditingController.text,
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

  Future<void> updateState() async {
    isLoading(true);
    final res = await stateProvider.updateOne(
      stateId: selectedState!.id!,
      stateData: {
        "name": textEditingController.text,
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

  Future<void> deleteState({required String stateId}) async {
    isLoading(true);
    final res = await stateProvider.deleteOne(stateId: stateId);
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) {
      pagingController.refresh();
    });
  }

  void setSelectedState(StateModel state) {
    textEditingController.text = state.name!;
    selectedState = state;
  }

  @override
  void onInit() {
    stateProvider = Get.find<StateProvider>();
    pagingController.addPageRequestListener((pageKey) {
      fetchStates(pageKey);
    });
    super.onInit();
  }

  void clearForm() {
    selectedState = null;
    textEditingController.clear();
  }

  @override
  void onClose() {
    pagingController.dispose();
    textEditingController.dispose();
    super.onClose();
  }
}
