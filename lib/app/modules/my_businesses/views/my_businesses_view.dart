import 'package:business_dir/app/data/models/business_owner_request_model.dart';
import 'package:business_dir/app/modules/home/controllers/home_controller.dart';
import 'package:business_dir/app/modules/manage_requests/views/widgets/r_status_container.dart';
import 'package:business_dir/app/widgets/r_card.dart';
import 'package:business_dir/app/widgets/r_gradient_button.dart';
import 'package:business_dir/app/widgets/r_linear_indicator.dart';
import 'package:business_dir/app/widgets/r_loading.dart';
import 'package:business_dir/app/widgets/r_not_found.dart';
import 'package:business_dir/app/widgets/r_text_icon_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../controllers/my_businesses_controller.dart';

class MyBusinessesView extends GetView<MyBusinessesController> {
  const MyBusinessesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          "myBusinesses".tr,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          RTextIconButton.medium(
            label: "add".tr,
            onPressed: () {
              Get.toNamed("/create-business");
            },
            icon: Icons.add,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Obx(
            () => controller.isLoading.isTrue
                ? const RLinearIndicator()
                : const SizedBox(),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => controller.pagingController.refresh(),
        ),
        child: PagedListView.separated(
          padding: const EdgeInsets.all(16),
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          pagingController: controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate<BusinessOwnerRequestModel>(
              animateTransitions: true,
              firstPageErrorIndicatorBuilder: (context) =>
                  RNotFound(label: "anErrorHasOccured".tr),
              newPageErrorIndicatorBuilder: (context) =>
                  RNotFound(label: "anErrorHasOccured".tr),
              firstPageProgressIndicatorBuilder: (context) => const RLoading(),
              noItemsFoundIndicatorBuilder: (context) =>
                  RNotFound(label: "noBusinessFound".tr),
              newPageProgressIndicatorBuilder: (context) => const RLoading(),
              itemBuilder: (context, request, index) {
                return GestureDetector(
                  onTap: () {
                    Get.find<HomeController>().business.value =
                        request.business;
                    Get.toNamed("/business-details");
                  },
                  child: RCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            request.business?.logo != null
                                ? FadeInImage.assetNetwork(
                                    placeholder: "assets/image.png",
                                    image: '${request.business?.logo?['url']}',
                                    height: 48,
                                    width: 48,
                                    imageErrorBuilder: (
                                      context,
                                      error,
                                      stackTrace,
                                    ) =>
                                        Image.asset(
                                      "assets/image.png",
                                      width: 48,
                                      height: 48,
                                    ),
                                  )
                                : Image.asset("assets/image.png",
                                    width: 48, height: 48),
                            Text(
                              '${request.business?.name}',
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  request.business?.averageRating
                                          ?.toStringAsFixed(1) ??
                                      "0.0",
                                ),
                                Icon(
                                  Icons.star_rounded,
                                  size: 16,
                                  color: context.theme.primaryColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Text(
                          '${request.business?.description}',
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RStatusContainer(status: '${request.status}'),
                            RTextIconButton.medium(
                              label: "editBusiness".tr,
                              onPressed: () {
                                controller.selectedBusiness.value =
                                    request.business;
                                Get.toNamed("/edit-business");
                              },
                              icon: Icons.arrow_right_alt_rounded,
                            ),
                          ],
                        ),
                        if (request.status == "approved") ...[
                          SizedBox(height: Get.height * 0.01),
                          RGradientButton(
                            label: "featureBusiness".tr,
                            onPressed: () {
                              controller.toBeFeaturedBusiness.value =
                                  request.business;
                              Get.toNamed("/feature-business");
                            },
                          )
                        ],
                      ],
                    ),
                  ),
                );
              }),
          separatorBuilder: (context, index) => SizedBox(
            height: Get.height * 0.02,
          ),
        ),
      ),
    );
  }
}
