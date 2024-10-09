import 'package:business_dir/app/controllers/auth_controller.dart';
import 'package:business_dir/app/controllers/theme_controller.dart';
import 'package:business_dir/app/modules/profile/controllers/profile_controller.dart';
import 'package:business_dir/app/modules/profile/views/widgets/r_profile_details_row.dart';
import 'package:business_dir/app/modules/profile/views/widgets/r_profile_page_tile.dart';
import 'package:business_dir/app/widgets/r_button.dart';
import 'package:business_dir/app/widgets/r_card.dart';
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
        leading: null,
        title: Text(
          "Profile",
          style: Get.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () {
          final user = authController.currentUser.value;
          return SingleChildScrollView(
            padding: EdgeInsets.all(12),
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                RCard(
                  color: context.theme.primaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (user != null) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: SizedBox(
                            width: 96,
                            height: 96,
                            child: user.profileImageUrl != null
                                ? Image.network(
                                    user.profileImageUrl!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset("assets/image.png");
                                    },
                                  )
                                : Image.network(
                                    "https://eu.ui-avatars.com/api/?name=${user.firstName}+${user.lastName}&size=250",
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset("assets/image.png");
                                    },
                                  ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Text(
                          '${user.firstName} ${user.lastName}',
                          style: Get.textTheme.titleLarge!.copyWith(
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
                          data:
                              DateFormat.yMMMd("en-us").format(user.createdAt!),
                        ),
                      ],
                      if (authController.currentUser.value == null) ...[
                        Text(
                          "Login or Sign up To View Your Profile",
                          style: Get.textTheme.bodyLarge!.copyWith(
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
                                Get.toNamed("signup");
                              },
                            ),
                            SizedBox(width: 12),
                            RButton(
                              child: Text("login".tr),
                              onPressed: () {
                                Get.toNamed("login");
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
                    physics: BouncingScrollPhysics(),
                    children: [
                      RProfilePageTile(
                        title: "theme".tr,
                        onPressed: null,
                        icon: Icons.color_lens_rounded,
                        trailing: DropdownButton(
                          value: themeController.currentTheme.value.name,
                          alignment: Alignment.centerRight,
                          style: Get.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          underline: SizedBox.shrink(),
                          icon: Icon(Icons.keyboard_arrow_down_rounded),
                          elevation: 0,
                          borderRadius: BorderRadius.circular(8),
                          items: [
                            DropdownMenuItem(
                              child: Text("system".tr),
                              value: "system",
                            ),
                            DropdownMenuItem(
                              child: Text("light".tr),
                              value: "light",
                            ),
                            DropdownMenuItem(
                              child: Text("dark".tr),
                              value: "dark",
                            )
                          ],
                          onChanged: (value) {
                            themeController.changeTheme(value ?? "system");
                          },
                        ),
                      ),
                      if (authController.currentUser.value?.role == "user")
                        RProfilePageTile(
                          title: "Become an Owner".tr,
                          icon: Icons.business_center_rounded,
                          onPressed: () {
                            Get.toNamed("privacy-policy");
                          },
                          trailing: Icon(Icons.arrow_right_alt_rounded),
                        ),
                      if (authController.currentUser.value?.role ==
                          "business_owner")
                        RProfilePageTile(
                          title: "My Businesses".tr,
                          icon: Icons.business_center_rounded,
                          onPressed: () {
                            Get.toNamed("my-businesses");
                          },
                          trailing: Icon(Icons.arrow_right_alt_rounded),
                        ),
                      RProfilePageTile(
                        title: "helpAndSupport".tr,
                        onPressed: () {
                          Get.toNamed("help-and-support");
                        },
                        icon: Icons.help,
                        trailing: Icon(Icons.arrow_right_alt_rounded),
                      ),
                      RProfilePageTile(
                        title: "privacyAndPolicy".tr,
                        icon: Icons.shield,
                        onPressed: () {
                          Get.toNamed("privacy-policy");
                        },
                        trailing: Icon(Icons.arrow_right_alt_rounded),
                      ),
                      RProfilePageTile(
                        title: "termsAndConditions".tr,
                        icon: Icons.article_sharp,
                        onPressed: () {
                          Get.toNamed("terms-and-conditions");
                        },
                        trailing: Icon(Icons.arrow_right_alt_rounded),
                      ),
                      if (user != null)
                        ListTile(
                          leading: Icon(Icons.logout),
                          title: Text("logout".tr),
                          trailing: Icon(Icons.arrow_right_alt_rounded),
                          iconColor: context.theme.colorScheme.error,
                          textColor: context.theme.colorScheme.error,
                          titleTextStyle: Get.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          onTap: () async {
                            await authController.logout();
                          },
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
