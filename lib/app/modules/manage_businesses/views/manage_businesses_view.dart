import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:business_dir/app/data/models/business_model.dart';
import 'package:business_dir/app/modules/home/controllers/home_controller.dart';
import 'package:business_dir/app/widgets/r_card.dart';
import 'package:business_dir/app/widgets/r_circled_image_avatar.dart';
import 'package:business_dir/app/widgets/r_delete_alert.dart';
import 'package:business_dir/app/widgets/r_loading.dart';
import 'package:business_dir/app/widgets/r_not_found.dart';
import 'package:business_dir/app/widgets/r_popup_menu_button.dart';
import 'package:business_dir/app/widgets/r_suspend_alert.dart';
import 'package:business_dir/app/widgets/r_text_icon_button.dart';
import 'package:business_dir/app/widgets/r_white_list_alert.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../controllers/manage_businesses_controller.dart';

class ManageBusinessesView extends GetView<ManageBusinessesController> {
  const ManageBusinessesView({super.key});
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
          "manageBusinesses".tr,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              Get.toNamed("/create-business");
            },
            icon: const Icon(Icons.add),
          ),
          AnimSearchBar(
            width: Get.width * 0.7,
            textController: controller.searchController,
            onSuffixTap: () {
              controller.searchController.clear();
              if (Get.focusScope?.hasFocus ?? false) {
                Get.focusScope!.unfocus();
              }
            },
            helpText: "Search businesses...",
            onSubmitted: (value) {
              controller.searchController.text = value;
              controller.pagingController.refresh();
            },
            color: Colors.transparent,
            boxShadow: false,
            closeSearchOnSuffixTap: true,
            autoFocus: true,
            searchIconColor: context.textTheme.bodyLarge!.color,
          ),
          Obx(
            () => RPopupMenuBtn(
              initialValue: controller.filterBy.value,
              onSelected: (value) {
                controller.filterBy.value = value;
                controller.pagingController.refresh();
              },
              children: [
                PopupMenuItem(
                  value: "all",
                  child: Text("allBusinesses".tr),
                ),
                PopupMenuItem(
                  value: "verified",
                  child: Text("verifiedBusinesses".tr),
                ),
                PopupMenuItem(
                  value: "suspended",
                  child: Text("suspendedBusinesses".tr),
                ),
              ],
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => controller.pagingController.refresh(),
        ),
        child: PagedListView.separated(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          pagingController: controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate<BusinessModel>(
            animateTransitions: true,
            firstPageErrorIndicatorBuilder: (context) =>
                RNotFound(label: "anErrorHasOccured".tr),
            newPageErrorIndicatorBuilder: (context) =>
                RNotFound(label: "anErrorHasOccured".tr),
            firstPageProgressIndicatorBuilder: (context) => const RLoading(),
            noItemsFoundIndicatorBuilder: (context) =>
                RNotFound(label: "noBusinessFound".tr),
            newPageProgressIndicatorBuilder: (context) => const RLoading(),
            itemBuilder: (context, business, index) => GestureDetector(
              onTap: () {
                Get.find<HomeController>().business.value = business;
                Get.toNamed("/business-details");
              },
              child: RCard(
                color: business.isSuspended ? Colors.red : null,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        if (business.isVerified!)
                          SizedBox(height: Get.height * 0.03),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RCircledImageAvatar.medium(
                              fallBackText: "${business.name?[0]}",
                              imageUrl: business.logo?['url'],
                            ),
                            SizedBox(width: Get.width * 0.02),
                            SizedBox(
                              width: Get.width * 0.6,
                              child: Text(
                                business.name!,
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: business.isSuspended
                                      ? Colors.white
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Text(
                          business.description!,
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: business.isSuspended ? Colors.white : null,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (!business.isSuspended)
                              RTextIconButton.medium(
                                label: "suspend".tr,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => RSuspendAlert(
                                      itemType: "business",
                                      onPressed: () async {
                                        Get.back();
                                        await controller.updateSuspendStatus(
                                          businessId: business.id!,
                                          suspend: true,
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: Icons.block_rounded,
                                color: Colors.yellow.shade800,
                              )
                            else
                              RTextIconButton.medium(
                                  label: "whitelist".tr,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => RWhiteListAlert(
                                        itemType: "business",
                                        onPressed: () async {
                                          Get.back();
                                          await controller.updateSuspendStatus(
                                            businessId: business.id!,
                                            suspend: false,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  icon: Icons.check_rounded,
                                  color: business.isSuspended
                                      ? Colors.white
                                      : null),
                            RTextIconButton.medium(
                              label: "delete".tr,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => RDeleteAlert(
                                    itemType: "business",
                                    onPressed: () async {
                                      Get.back();
                                      await controller.deleteBusiness(
                                        businessId: business.id!,
                                      );
                                    },
                                  ),
                                );
                              },
                              icon: Icons.delete_rounded,
                              color: business.isSuspended
                                  ? Colors.white
                                  : Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (business.isSuspended)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          child: Text(
                            "suspended".tr,
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    if (business.isVerified!)
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.verified_rounded,
                              size: 16,
                              color: business.isSuspended
                                  ? Colors.white
                                  : context.theme.primaryColor,
                            ),
                            Text(
                              "verifiedBusiness".tr,
                              style: context.textTheme.bodySmall!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: business.isSuspended
                                    ? Colors.white
                                    : context.theme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          separatorBuilder: (context, index) => SizedBox(
            height: Get.height * 0.02,
          ),
        ),
      ),
    );
  }
}
