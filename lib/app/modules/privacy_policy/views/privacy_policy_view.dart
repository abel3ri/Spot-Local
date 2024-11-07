import 'package:business_dir/app/widgets/r_detailed_text_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/privacy_policy_controller.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyView({super.key});
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
          "privacyPolicy".tr,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "yourPrivacyIs".tr,
              style: context.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            RDetailedTextCard(
              heading: "infoCollection".tr,
              body: "weCollectPersonal".tr,
            ),
            SizedBox(height: Get.height * 0.01),
            RDetailedTextCard(
              heading: "usageOfInfo".tr,
              body: "weUseYourData".tr,
            ),
            SizedBox(height: Get.height * 0.01),
            RDetailedTextCard(
              heading: "dataSecurity".tr,
              body: "weImplement".tr,
            ),
            SizedBox(height: Get.height * 0.01),
            RDetailedTextCard(
              heading: "modifications".tr,
              body: "weReserve".tr,
            ),
          ],
        ),
      ),
    );
  }
}
