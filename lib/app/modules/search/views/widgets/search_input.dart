import 'package:business_dir/app/modules/search/controllers/search_controller.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';

class SearchInput extends GetView<SearchController> {
  SearchInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: controller.searchInputController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          hintText: "searchBusiness".tr,
          hintStyle: Get.textTheme.bodyMedium!.copyWith(
            color: Colors.grey.shade600,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Get.theme.primaryColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(
              color: Get.theme.primaryColor,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(
              color: Get.theme.primaryColor,
              width: 2,
            ),
          ),
          filled: true,
        ),
        textInputAction: TextInputAction.search,
        onChanged: (value) {
          controller.searchBusiness(query: value);
        },
      ),
    );
  }
}
