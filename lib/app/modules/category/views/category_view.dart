import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:business_dir/app/data/models/business_model.dart';
import 'package:business_dir/app/modules/category/controllers/category_controller.dart';
import 'package:business_dir/app/widgets/r_business_container.dart';
import 'package:business_dir/app/widgets/r_loading.dart';
import 'package:business_dir/app/widgets/r_not_found.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({super.key});
  @override
  Widget build(BuildContext context) {
    final categoryName = Get.arguments?['name'] ?? "No name";
    final categoryDescription =
        Get.arguments?['description'] ?? "No description";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$categoryName - $categoryDescription',
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 22,
          ),
        ),
        actions: [
          AnimSearchBar(
            width: Get.width * .95,
            textController: controller.searchController,
            onSuffixTap: () {
              controller.searchController.clear();
              if (Get.focusScope?.hasFocus ?? false) {
                Get.focusScope!.unfocus();
              }
            },
            onSubmitted: (value) {
              controller.searchController.text = value;
              controller.pagingController.refresh();
            },
            boxShadow: false,
            color: Colors.transparent,
            helpText: "Search businesses in $categoryName...",
            closeSearchOnSuffixTap: true,
            autoFocus: true,
            searchIconColor: context.textTheme.bodyLarge!.color,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => controller.pagingController.refresh(),
        ),
        child: PagedMasonryGridView.count(
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          padding: const EdgeInsets.all(16),
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          pagingController: controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate<BusinessModel>(
            animateTransitions: true,
            firstPageErrorIndicatorBuilder: (context) =>
                const RNotFound(label: "An error has occured!"),
            newPageErrorIndicatorBuilder: (context) =>
                const RNotFound(label: "An error has occured!"),
            firstPageProgressIndicatorBuilder: (context) => const RLoading(),
            newPageProgressIndicatorBuilder: (context) => const RLoading(),
            noItemsFoundIndicatorBuilder: (context) =>
                const RNotFound(label: "No business found!"),
            itemBuilder: (context, business, index) {
              return RBusinessContainer(business: business);
            },
          ),
          crossAxisCount: 2,
        ),
      ),
    );
  }
}
