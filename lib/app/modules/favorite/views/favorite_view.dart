import 'package:business_dir/app/controllers/auth_controller.dart';
import 'package:business_dir/app/data/models/favorite_model.dart';
import 'package:business_dir/app/modules/favorite/controllers/favorite_controller.dart';
import 'package:business_dir/app/widgets/r_business_container.dart';
import 'package:business_dir/app/widgets/r_loading.dart';
import 'package:business_dir/app/widgets/r_not_found.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class FavoriteView extends GetView<FavoriteController> {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "favoritedBusinesses".tr,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => authController.currentUser.value != null
            ? RefreshIndicator(
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
                  builderDelegate: PagedChildBuilderDelegate<FavoriteModel>(
                    animateTransitions: true,
                    firstPageErrorIndicatorBuilder: (context) =>
                        RNotFound(label: "anErrorHasOccured".tr),
                    newPageErrorIndicatorBuilder: (context) =>
                        RNotFound(label: "anErrorHasOccured".tr),
                    firstPageProgressIndicatorBuilder: (context) =>
                        const RLoading(),
                    newPageProgressIndicatorBuilder: (context) =>
                        const RLoading(),
                    noItemsFoundIndicatorBuilder: (context) =>
                        RNotFound(label: "noFavoritedBusinessFound".tr),
                    itemBuilder: (context, favorite, index) {
                      return RBusinessContainer(business: favorite.business!);
                    },
                  ),
                  crossAxisCount: 2,
                ),
              )
            : RNotFound(
                label: "pleaseLoginToSeeYourFavorited".tr,
              ),
      ),
    );
  }
}
