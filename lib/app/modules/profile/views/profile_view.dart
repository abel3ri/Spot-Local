import 'package:business_dir/app/controllers/auth_controller.dart';
import 'package:business_dir/app/controllers/theme_controller.dart';
import 'package:business_dir/app/modules/profile/controllers/profile_controller.dart';
import 'package:business_dir/app/modules/profile/views/widgets/r_profile_details_row.dart';
import 'package:business_dir/app/modules/profile/views/widgets/r_profile_page_tile.dart';
import 'package:business_dir/app/widgets/r_button.dart';
import 'package:business_dir/app/widgets/r_card.dart';
import 'package:business_dir/app/widgets/r_circled_image_avatar.dart';
import 'package:business_dir/app/widgets/r_loading.dart';
import 'package:business_dir/app/widgets/r_text_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProfileView extends GetView<ProfileController> {
  final authController = Get.find<AuthController>();
  final themeController = Get.find<ThemeController>();
  ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "profile".tr,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Obx(
            () {
              if (authController.currentUser.value != null) {
                return RTextIconButton(
                  label: "edit".tr,
                  onPressed: () {
                    Get.toNamed("/edit-profile");
                  },
                  icon: Icons.arrow_right_alt_rounded,
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
      body: Obx(
        () {
          if (controller.isLoading.isTrue) {
            return const Center(
              child: RLoading(),
            );
          }
          final user = authController.currentUser.value;
          return RefreshIndicator(
            onRefresh: () => Future.sync(() => authController.getUserData()),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Column(
                children: [
                  RCard(
                    color: context.theme.primaryColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (user != null) ...[
                          RCircledImageAvatar(
                            imageUrl: user.profileImage?['url'],
                            fallBackText:
                                '${user.firstName?[0]}${user.lastName![0]}',
                          ),
                          SizedBox(height: Get.height * 0.01),
                          Text(
                            '${user.firstName} ${user.lastName}',
                            style: context.textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: Get.height * 0.02),
                          RProfileDetailRow(
                            label: "email".tr,
                            data: "${user.email}".toLowerCase(),
                          ),
                          SizedBox(height: Get.height * 0.02),
                          RProfileDetailRow(
                            label: "username".tr,
                            data: '@${user.username}',
                          ),
                          SizedBox(height: Get.height * 0.02),
                          RProfileDetailRow(
                            label: "dateJoined".tr,
                            data: DateFormat.yMMMd("en-us")
                                .format(user.createdAt!),
                          ),
                        ],
                        if (authController.currentUser.value == null) ...[
                          Text(
                            "loginOrSignUpToViewProfile".tr,
                            style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RButton(
                                child: Text("signup".tr),
                                onPressed: () {
                                  Get.offAllNamed("signup", arguments: {
                                    "previousRoute": "home",
                                  });
                                },
                              ),
                              const SizedBox(width: 12),
                              RButton(
                                child: Text("login".tr),
                                onPressed: () {
                                  Get.offAllNamed("login", arguments: {
                                    "previousRoute": "home",
                                  });
                                },
                              ),
                            ],
                          ),
                        ]
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  RCard(
                    child: ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        RProfilePageTile(
                          title: "theme".tr,
                          onPressed: null,
                          icon: Icons.color_lens_rounded,
                          trailing: DropdownButton(
                            value: themeController.currentTheme.value.name,
                            alignment: Alignment.centerRight,
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            underline: const SizedBox.shrink(),
                            icon: const Icon(Icons.keyboard_arrow_down_rounded),
                            elevation: 0,
                            borderRadius: BorderRadius.circular(8),
                            items: [
                              DropdownMenuItem(
                                value: "system",
                                child: Text("system".tr),
                              ),
                              DropdownMenuItem(
                                value: "light",
                                child: Text("light".tr),
                              ),
                              DropdownMenuItem(
                                value: "dark",
                                child: Text("dark".tr),
                              )
                            ],
                            onChanged: (value) {
                              themeController.changeTheme(value ?? "system");
                            },
                          ),
                        ),
                        if (authController.currentUser.value?.role == "user")
                          RProfilePageTile(
                            title: "becomeAnOwner".tr,
                            icon: Icons.business_center_rounded,
                            onPressed: () {
                              Get.toNamed("/create-business");
                            },
                            trailing: const Icon(Icons.arrow_right_alt_rounded),
                          ),
                        if (authController.currentUser.value?.role ==
                            "business_owner") ...[
                          RProfilePageTile(
                            title: "myBusinesses".tr,
                            icon: Icons.business_center_rounded,
                            onPressed: () {
                              Get.toNamed("/my-businesses");
                            },
                            trailing: const Icon(Icons.arrow_right_alt_rounded),
                          ),
                          RProfilePageTile(
                            title: "featureHistory".tr,
                            icon: Icons.history_rounded,
                            onPressed: () {
                              Get.toNamed("/feature-history");
                            },
                            trailing: const Icon(Icons.arrow_right_alt_rounded),
                          ),
                        ],
                        if (authController.currentUser.value?.role == "admin")
                          RProfilePageTile(
                            title: "adminPanel".tr,
                            onPressed: () {
                              Get.toNamed("/admin-panel");
                            },
                            icon: Icons.dashboard_rounded,
                            trailing: const Icon(Icons.arrow_right_alt_rounded),
                          ),
                        RProfilePageTile(
                          title: "language".tr,
                          onPressed: () {
                            Get.toNamed("change-language");
                          },
                          icon: Icons.translate_rounded,
                          trailing: const Icon(Icons.arrow_right_alt_rounded),
                        ),
                        RProfilePageTile(
                          title: "helpAndSupport".tr,
                          onPressed: () {
                            Get.toNamed("help-and-support");
                          },
                          icon: Icons.help,
                          trailing: const Icon(Icons.arrow_right_alt_rounded),
                        ),
                        RProfilePageTile(
                          title: "privacyAndPolicy".tr,
                          icon: Icons.shield,
                          onPressed: () {
                            Get.toNamed("privacy-policy");
                          },
                          trailing: const Icon(Icons.arrow_right_alt_rounded),
                        ),
                        RProfilePageTile(
                          title: "termsAndConditions".tr,
                          icon: Icons.article_sharp,
                          onPressed: () {
                            Get.toNamed("terms-and-conditions");
                          },
                          trailing: const Icon(Icons.arrow_right_alt_rounded),
                        ),
                        if (user != null) ...[
                          ListTile(
                            leading: const Icon(Icons.logout),
                            title: Text("logout".tr),
                            trailing: const Icon(Icons.arrow_right_alt_rounded),
                            iconColor: context.theme.colorScheme.error,
                            textColor: context.theme.colorScheme.error,
                            titleTextStyle:
                                context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            onTap: () async {
                              await authController.logout();
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.delete_forever_rounded),
                            title: Text("deleteAccount".tr),
                            trailing: const Icon(Icons.arrow_right_alt_rounded),
                            iconColor: context.theme.colorScheme.error,
                            textColor: context.theme.colorScheme.error,
                            titleTextStyle:
                                context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  title: Text("areYouSureToDeleteAccount".tr),
                                  content: Text("proceedWithCaution".tr),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        Get.back();
                                        await controller.deleteAccount();
                                      },
                                      child: Text("iUnderstand".tr),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text("cancel".tr),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
