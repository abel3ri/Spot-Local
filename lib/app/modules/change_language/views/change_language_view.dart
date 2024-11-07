import 'package:business_dir/app/controllers/locale_controller.dart';
import 'package:business_dir/app/modules/change_language/widgets/r_language_selection_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeLanguageView extends GetView<LocaleController> {
  const ChangeLanguageView({super.key});
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
          "changeLanguage".tr,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(
              () => RLanguageSelectionTile(
                flagPath: "assets/flags/us.png",
                language: "English",
                onChanged: (value) {
                  controller.changeLocale('en');
                },
                value: controller.currentLocale.value == const Locale("en"),
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            Obx(
              () => RLanguageSelectionTile(
                flagPath: "assets/flags/et.png",
                language: "አማርኛ",
                onChanged: (value) {
                  controller.changeLocale("am");
                },
                value: controller.currentLocale.value == const Locale("am"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
