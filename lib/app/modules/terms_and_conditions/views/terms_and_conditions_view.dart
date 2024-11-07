import 'package:business_dir/app/widgets/r_detailed_text_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/terms_and_conditions_controller.dart';

class TermsAndConditionsView extends GetView<TermsAndConditionsController> {
  const TermsAndConditionsView({super.key});
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
          "termsAndConditions".tr,
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
              "byUsingETechs".tr,
              style: context.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            RDetailedTextCard(
              heading: "userAccounts".tr,
              body: "userMustCreate".tr,
            ),
            SizedBox(height: Get.height * 0.01),
            RDetailedTextCard(
              heading: "contentUsage".tr,
              body: "theContentProvided".tr,
            ),
            SizedBox(height: Get.height * 0.01),
            RDetailedTextCard(
              heading: "userConduct".tr,
              body: "youAgreeNot".tr,
            ),
            SizedBox(height: Get.height * 0.01),
            RDetailedTextCard(
              heading: "modifications".tr,
              body: "youReserve".tr,
            ),
          ],
        ),
      ),
    );
  }
}
