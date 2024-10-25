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
        title: Obx(
          () => Text(
            "${controller.filterBy.value.capitalize} - Requests",
            style: context.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          Obx(
            () => RPopupMenuBtn(
              children: [
                PopupMenuItem(
                  child: Text("All requests"),
                  value: "all",
                ),
                PopupMenuItem(
                  child: Text("Pending requests"),
                  value: "pending",
                ),
                PopupMenuItem(
                  child: Text("Approved requests"),
                  value: "approved",
                ),
                PopupMenuItem(
                  child: Text("Rejected requests"),
                  value: "rejected",
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
          builderDelegate: PagedChildBuilderDelegate<BusinessOwnerRequestModel>(
            animateTransitions: true,
            firstPageErrorIndicatorBuilder: (context) =>
                RNotFound(label: "An error has occured!"),
            newPageErrorIndicatorBuilder: (context) =>
                RNotFound(label: "An error has occured!"),
            firstPageProgressIndicatorBuilder: (context) => RLoading(),
            noItemsFoundIndicatorBuilder: (context) =>
                RNotFound(label: "No business found!"),
            newPageProgressIndicatorBuilder: (context) => RLoading(),
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
                              text: "Requested on ",
                              children: [
                                TextSpan(
                                  text: "${DateFormat.yMMMd("en-US").format(
                                    request.createdAt!,
                                  )}",
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text('${request.business?.address}'),
                          SizedBox(height: Get.height * 0.01),
                          RTextIconButton.medium(
                            label: "Business License",
                            onPressed: () {
                              Get.toNamed("/image-preview", arguments: {
                                "imagePath":
                                    request.business!.businessLicense!['url'],
                                "imageType": "network",
                              });
                            },
                            icon: Icons.article_rounded,
                          ),
                          if (request.status == "pending") ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RTextIconButton.medium(
                                  label: "Approve",
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
                                  label: "Reject",
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
                                label: "Approve",
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
                                label: "Reject",
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
                          ],
                        ],
                      ),
                      Positioned(
                        child: RStatusContainer(status: request.status!),
                        top: 0,
                        right: 0,
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
