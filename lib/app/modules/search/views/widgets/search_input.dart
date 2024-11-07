import 'package:business_dir/app/modules/search/controllers/search_controller.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';

class SearchInput extends GetView<SearchController> {
  const SearchInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: controller.searchInputController,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          hintText: "searchBusiness".tr,
          hintStyle: context.textTheme.bodyMedium!.copyWith(
            color: Colors.grey.shade600,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: context.theme.primaryColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(
              color: context.theme.primaryColor,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(
              color: context.theme.primaryColor,
              width: 2,
            ),
          ),
          filled: true,
        ),
        textInputAction: TextInputAction.search,
        onChanged: (value) async {
          await controller.searchBusiness(query: value);
        },
      ),
    );
  }
}
