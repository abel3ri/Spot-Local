import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:business_dir/app/data/models/business_model.dart';
import 'package:business_dir/app/widgets/r_alert_dialog.dart';
import 'package:business_dir/app/widgets/r_card.dart';
import 'package:business_dir/app/widgets/r_loading.dart';
import 'package:business_dir/app/widgets/r_not_found.dart';
import 'package:business_dir/app/widgets/r_popup_menu_button.dart';
import 'package:business_dir/app/widgets/r_text_icon_button.dart';
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
          "Manage businesses".tr,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          AnimSearchBar(
            width: Get.width * 0.85,
            textController: controller.searchController,
            onSuffixTap: () {
              controller.searchController.clear();
            },
            helpText: "Search businesses...",
            onSubmitted: (value) {
              controller.searchController.text = value;
              controller.pagingController.refresh();
            },
            color: Colors.transparent,
            boxShadow: false,
          ),
          Obx(
            () => RPopupMenuBtn(
              children: [
                PopupMenuItem(
                  child: Text("All Businesses"),
                  value: "all",
                ),
                PopupMenuItem(
                  child: Text("Verified Businesses"),
                  value: "pending",
                ),
                PopupMenuItem(
                  child: Text("Suspended Businesses"),
                  value: "approved",
                ),
              ],
              initialValue: controller.filterBy.value,
              onSelected: (value) {
                controller.filterBy.value = value;
                controller.pagingController.refresh();
              },
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => controller.pagingController.refresh(),
        ),
        child: PagedListView.separated(
          padding: EdgeInsets.all(16),
          physics: BouncingScrollPhysics(),
          pagingController: controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate<BusinessModel>(
            animateTransitions: true,
            firstPageErrorIndicatorBuilder: (context) =>
                RNotFound(label: "An error has occured!"),
            newPageErrorIndicatorBuilder: (context) =>
                RNotFound(label: "An error has occured!"),
            firstPageProgressIndicatorBuilder: (context) => RLoading(),
            noItemsFoundIndicatorBuilder: (context) =>
                RNotFound(label: "No business found!"),
            newPageProgressIndicatorBuilder: (context) => RLoading(),
            itemBuilder: (context, business, index) => RCard(
              child: Stack(
                children: [
                  Column(
                    children: [
                      if (business.isVerified!)
                        SizedBox(height: Get.height * 0.03),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 64,
                            width: 64,
                            child: business.logo != null
                                ? FadeInImage.assetNetwork(
                                    placeholder: "assets/image.png",
                                    image: business.logo?['url'],
                                    fit: BoxFit.cover,
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset(
                                        "assets/image.png",
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  )
                                : Image.asset(
                                    "assets/image.png",
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          SizedBox(width: Get.width * 0.02),
                          Text(
                            business.name!,
                            style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.02),
                      Text(business.description!),
                      SizedBox(height: Get.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (!business.isSuspended)
                            RTextIconButton.medium(
                              label: "Suspend",
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => RAlertDialog(
                                    title:
                                        "Are you sure you want to suspend this business?",
                                    description:
                                        "Make sure you carefully review the business before you suspend.",
                                    btnLabel: "Suspend",
                                    onLabelBtnTap: () async {
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
                              label: "Whitelist",
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => RAlertDialog(
                                    title:
                                        "Are you sure you want to whitelist this business?",
                                    description:
                                        "Make sure you carefully review the business before you whitelist.",
                                    btnLabel: "Whitelist",
                                    onLabelBtnTap: () async {
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
                              color: Colors.green,
                            ),
                          RTextIconButton.medium(
                            label: "Delete",
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => RAlertDialog(
                                  title:
                                      "Are you sure you want to delete this business?",
                                  description:
                                      "Make sure to carefully review the business before you delete.",
                                  btnLabel: "Delete",
                                  onLabelBtnTap: () async {
                                    Get.back();
                                    await controller.deleteBusiness(
                                      businessId: business.id!,
                                    );
                                  },
                                ),
                              );
                            },
                            icon: Icons.delete_rounded,
                            color: Colors.red,
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
                          "Suspended",
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
                            color: context.theme.primaryColor,
                          ),
                          Text(
                            "Verified Business",
                            style: context.textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
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
