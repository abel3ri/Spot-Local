import 'package:business_dir/app/data/models/featured_model.dart';
import 'package:business_dir/app/widgets/r_alert_dialog.dart';
import 'package:business_dir/app/widgets/r_featured_container.dart';
import 'package:business_dir/app/widgets/r_loading.dart';
import 'package:business_dir/app/widgets/r_not_found.dart';
import 'package:business_dir/app/widgets/r_popup_menu_button.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../controllers/manage_feature_requests_controller.dart';

class ManageFeatureRequestsView
    extends GetView<ManageFeatureRequestsController> {
  const ManageFeatureRequestsView({super.key});
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
          "manageFeatureRequests".tr,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
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
                  child: Text("allRequests".tr),
                ),
                PopupMenuItem(
                  value: "pending",
                  child: Text("pendingRequests".tr),
                ),
                PopupMenuItem(
                  value: "active",
                  child: Text("activeRequests".tr),
                ),
                PopupMenuItem(
                  value: "expired",
                  child: Text("expiredRequests".tr),
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
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          pagingController: controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate<FeaturedModel>(
            animateTransitions: true,
            firstPageErrorIndicatorBuilder: (context) =>
                RNotFound(label: "anErrorHasOccured".tr),
            newPageErrorIndicatorBuilder: (context) =>
                RNotFound(label: "anErrorHasOccured".tr),
            firstPageProgressIndicatorBuilder: (context) => const RLoading(),
            noItemsFoundIndicatorBuilder: (context) =>
                RNotFound(label: "noFeatureRequestFound".tr),
            newPageProgressIndicatorBuilder: (context) => const RLoading(),
            itemBuilder: (context, featured, index) {
              return RFeaturedContainer(
                featured: featured,
                userRole: "admin",
                onApproveBtnTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => RAlertDialog(
                      title: "approveFeatureRequest".tr,
                      description: "approveTransactionMessage".tr,
                      btnLabel: "approve".tr,
                      onLabelBtnTap: () async {
                        Get.back();
                        await controller.updateFeatured(
                          featuredId: featured.id!,
                          status: "active",
                        );
                      },
                    ),
                  );
                },
                onMarkExpireBtnTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => RAlertDialog(
                      title: "markFeatureRequestExpired".tr,
                      description: "reviewRequestMessage".tr,
                      btnLabel: "markExpiredBtnLabel".tr,
                      onLabelBtnTap: () async {
                        Get.back();
                        await controller.updateFeatured(
                          featuredId: featured.id!,
                          status: "expired",
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
          separatorBuilder: (context, index) =>
              SizedBox(height: Get.height * 0.02),
        ),
      ),
    );
  }
}
