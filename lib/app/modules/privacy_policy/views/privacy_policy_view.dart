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
          "Privacy Policy",
          style: Get.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Your privacy is important to us. This Privacy Policy outlines how we collect, use, and protect your personal information when you use our app.",
              style: Get.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            RDetailedTextCard(
              heading: "Information Collection: ",
              body:
                  "We collect personal information like your name, email address, and usage data to provide and improve the app’s services.",
            ),
            SizedBox(height: Get.height * 0.01),
            RDetailedTextCard(
              heading: "Usage of Information: ",
              body:
                  " We use your data to personalize your experience, improve our app, and communicate with you.",
            ),
            SizedBox(height: Get.height * 0.01),
            RDetailedTextCard(
              heading: "Data Security: ",
              body:
                  "We implement robust security measures to protect your data from unauthorized access.",
            ),
            SizedBox(height: Get.height * 0.01),
            RDetailedTextCard(
              heading: "Modifications: ",
              body:
                  "We reserve the right to modify or discontinue any part of the app without prior notice.",
            ),
          ],
        ),
      ),
    );
  }
}
