import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:business_dir/app/controllers/auth_controller.dart';
import 'package:business_dir/app/data/models/user_model.dart';

import 'package:business_dir/app/widgets/r_card.dart';
import 'package:business_dir/app/widgets/r_circled_image_avatar.dart';
import 'package:business_dir/app/widgets/r_delete_alert.dart';
import 'package:business_dir/app/widgets/r_loading.dart';
import 'package:business_dir/app/widgets/r_not_found.dart';
import 'package:business_dir/app/widgets/r_suspend_alert.dart';
import 'package:business_dir/app/widgets/r_text_icon_button.dart';
import 'package:business_dir/app/widgets/r_user_profile_text.dart';
import 'package:business_dir/app/widgets/r_white_list_alert.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/manage_users_controller.dart';

class ManageUsersView extends GetView<ManageUsersController> {
  const ManageUsersView({super.key});
  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          "manageUsers".tr,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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
            helpText: "searchUsers".tr,
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
        child: PagedListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          pagingController: controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate<UserModel>(
            animateTransitions: true,
            firstPageErrorIndicatorBuilder: (context) =>
                RNotFound(label: "anErrorHasOccured".tr),
            newPageErrorIndicatorBuilder: (context) =>
                RNotFound(label: "anErrorHasOccured".tr),
            firstPageProgressIndicatorBuilder: (context) => const RLoading(),
            noItemsFoundIndicatorBuilder: (context) =>
                RNotFound(label: "noUserFound".tr),
            newPageProgressIndicatorBuilder: (context) => const RLoading(),
            itemBuilder: (context, user, index) {
              return RCard(
                color: user.isSuspended! ? Colors.red : null,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        RCircledImageAvatar.medium(
                          imageUrl: user.profileImage?["url"],
                          fallBackText:
                              "${user.firstName?[0]}${user.lastName?[0]}",
                        ),
                        SizedBox(width: Get.width * 0.03),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: Get.height * 0.01),
                            Center(
                              child: Text(
                                "${user.firstName} ${user.lastName}",
                                style: context.textTheme.titleLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      user.isSuspended! ? Colors.white : null,
                                ),
                              ),
                            ),
                            SizedBox(height: Get.height * 0.01),
                            RUserProfileText(
                              label: "username".tr,
                              isSuspended: user.isSuspended!,
                              text: "@${user.username}",
                            ),
                            SizedBox(height: Get.height * 0.01),
                            GestureDetector(
                              onTap: () {
                                launchUrl(Uri.parse("mailto:${user.email}"));
                              },
                              child: RUserProfileText(
                                label: "email".tr,
                                isSuspended: user.isSuspended!,
                                text: "${user.email}",
                              ),
                            ),
                            SizedBox(height: Get.height * 0.01),
                            RUserProfileText(
                              label: "role".tr,
                              isSuspended: user.isSuspended!,
                              text: "${user.role}",
                            ),
                            SizedBox(height: Get.height * 0.01),
                            RUserProfileText(
                              label: "tin".tr,
                              isSuspended: user.isSuspended!,
                              text: "${user.tin}",
                            ),
                            SizedBox(height: Get.height * 0.01),
                            RUserProfileText(
                              label: "dateJoined".tr,
                              isSuspended: user.isSuspended!,
                              text: DateFormat.yMMMd("en-US")
                                  .format(user.createdAt!),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (user.isSuspended ?? false)
                              RTextIconButton.medium(
                                color: Colors.white,
                                label: "whitelist".tr,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => RWhiteListAlert(
                                      itemType: "user",
                                      onPressed: () async {
                                        Get.back();
                                        await controller.updateSuspendedStatus(
                                          userId: user.id!,
                                          isSuspended: false,
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: Icons.check_rounded,
                              )
                            else
                              RTextIconButton.medium(
                                label: "suspend".tr,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => RSuspendAlert(
                                      itemType: "user",
                                      onPressed: () async {
                                        Get.back();
                                        await controller.updateSuspendedStatus(
                                          userId: user.id!,
                                          isSuspended: true,
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: Icons.block_rounded,
                                color: Colors.yellow.shade700,
                              ),
                            RTextIconButton.medium(
                              label: "delete".tr,
                              color:
                                  user.isSuspended! ? Colors.white : Colors.red,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => RDeleteAlert(
                                    itemType: "user",
                                    onPressed: () async {
                                      Get.back();
                                      await controller.deleteUser(
                                        userId: user.id!,
                                      );
                                    },
                                  ),
                                );
                              },
                              icon: Icons.delete_rounded,
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (user.isSuspended ?? false)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Text(
                          "suspended".tr,
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    if (authController.currentUser.value?.id == user.id)
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Text(
                          "you".tr,
                          style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: user.isSuspended! ? Colors.white : null,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          separatorBuilder: (context, index) => SizedBox(
            height: Get.height * 0.02,
          ),
        ),
      ),
    );
  }
}
