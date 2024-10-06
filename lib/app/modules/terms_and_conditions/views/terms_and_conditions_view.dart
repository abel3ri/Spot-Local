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
          "Terms and Conditions",
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
              "By using eTech's Business Directory app, you agree to the following terms and conditions:",
              style: Get.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            RDetailedTextCard(
              heading: "User Accounts: ",
              body:
                  "Users must create an account to access certain features. You are responsible for maintaining the confidentiality of your account information.",
            ),
            SizedBox(height: Get.height * 0.01),
            RDetailedTextCard(
              heading: "Content Usage: ",
              body:
                  "The content provided in the app is for informational purposes only. Any business listings, reviews, or user-generated content are not verified by the Ethiopian Government.",
            ),
            SizedBox(height: Get.height * 0.01),
            RDetailedTextCard(
              heading: "User Conduct: ",
              body:
                  "You agree not to use the app for any unlawful purposes or to submit harmful or offensive content.",
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
