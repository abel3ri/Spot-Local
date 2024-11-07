import 'package:business_dir/app/data/models/business_owner_request_model.dart';
import 'package:business_dir/app/modules/home/controllers/home_controller.dart';
import 'package:business_dir/app/modules/manage_requests/views/widgets/r_approve_alert.dart';
import 'package:business_dir/app/modules/manage_requests/views/widgets/r_reject_alert.dart';
import 'package:business_dir/app/modules/manage_requests/views/widgets/r_status_container.dart';
import 'package:business_dir/app/widgets/r_card.dart';
import 'package:business_dir/app/widgets/r_chip.dart';
import 'package:business_dir/app/widgets/r_header_text.dart';
import 'package:business_dir/app/widgets/r_loading.dart';
import 'package:business_dir/app/widgets/r_not_found.dart';
import 'package:business_dir/app/widgets/r_popup_menu_button.dart';
import 'package:business_dir/app/widgets/r_text_icon_button.dart';
import 'package:business_dir/app/widgets/shimmers/r_circled_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import '../controllers/manage_requests_controller.dart';

class ManageRequestsView extends GetView<ManageRequestsController> {
  const ManageRequestsView({super.key});
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
          "manageRequests".tr,
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
                  value: "approved",
                  child: Text("approvedRequests".tr),
                ),
                PopupMenuItem(
                  value: "rejected",
                  child: Text("rejectedRequests".tr),
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
                  Get.find<HomeController>().business.value = request.business;
                  Get.toNamed("/business-details");
                },
                child: RCard(
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RHeaderText(
                            headerText: '${request.business?.name}',
                          ),
                          if (request.business?.categories != null) ...[
                            SizedBox(height: Get.height * 0.01),
                            Wrap(
                              spacing: 4,
                              children: List.generate(
                                request.business!.categories!.length,
                                (index) => RChip(
                                  label:
                                      request.business!.categories![index].name,
                                ),
                              ),
                            ),
                            SizedBox(height: Get.height * 0.01),
                          ],
                          Text(
                            '${request.business?.licenseNumber}',
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              text: "requestedOn".tr,
                              children: [
                                TextSpan(
                                  text: DateFormat.yMMMd("en-US").format(
                                    request.createdAt!,
                                  ),
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '${request.business?.address}',
                            style: context.textTheme.bodyMedium!.copyWith(),
                          ),
                          SizedBox(height: Get.height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RCircledButton.large(
                                icon: Icons.article_rounded,
                                onTap: () {
                                  Get.toNamed("/image-preview", arguments: {
                                    "imagePath": request
                                        .business!.businessLicense!['url'],
                                  });
                                },
                              ),
                              if (request.status == "pending") ...[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    RTextIconButton.medium(
                                      label: "approve".tr,
                                      color: Colors.green,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => RApproveAlert(
                                            requestId: request.id!,
                                          ),
                                        );
                                      },
                                      icon: Icons.check_rounded,
                                    ),
                                    SizedBox(width: Get.width * 0.01),
                                    RTextIconButton.medium(
                                      label: "reject".tr,
                                      color: Colors.red,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => RRejectAlert(
                                            requestId: request.id!,
                                          ),
                                        );
                                      },
                                      icon: Icons.block_rounded,
                                    ),
                                  ],
                                ),
                              ],
                              if (request.status == 'rejected') ...[
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: RTextIconButton.medium(
                                    label: "approve".tr,
                                    color: Colors.green,
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => RApproveAlert(
                                          requestId: request.id!,
                                        ),
                                      );
                                    },
                                    icon: Icons.check_rounded,
                                  ),
                                ),
                              ],
                              if (request.status == 'approved') ...[
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: RTextIconButton.medium(
                                    label: "reject".tr,
                                    color: Colors.red,
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => RRejectAlert(
                                          requestId: request.id!,
                                        ),
                                      );
                                    },
                                    icon: Icons.block_rounded,
                                  ),
                                ),
                              ]
                            ],
                          ),
                        ],
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: RStatusContainer(status: request.status!),
                      ),
                    ],
                  ),
                ),
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
