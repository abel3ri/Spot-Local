import 'package:business_dir/app/widgets/r_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/get_started_controller.dart';

class GetStartedView extends GetView<GetStartedController> {
  const GetStartedView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: () {
              Get.offNamed("home-wrapper");
            },
            style: ButtonStyle(
              textStyle: WidgetStatePropertyAll(
                Get.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            child: Text(
              "skip".tr,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "welcomeToeTech".tr,
              textAlign: TextAlign.center,
              style: Get.textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            Text(
              "letUsHelp".tr,
              textAlign: TextAlign.center,
              style: Get.textTheme.bodyLarge,
            ),
            SizedBox(height: Get.height * 0.04),
            const Center(
              child: Icon(
                Icons.business,
                size: 260,
              ),
            ),
            const Spacer(),
            Text.rich(
              textAlign: TextAlign.center,
              style: Get.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
              TextSpan(
                text: "iAgreeTo".tr,
                children: [
                  TextSpan(
                    text: "termsOfServices".tr,
                    style: TextStyle(
                      color: Get.theme.colorScheme.primary,
                    ),
                  ),
                  TextSpan(
                    text: "confirmThat".tr,
                  ),
                  TextSpan(
                    text: "privacyPolicy".tr,
                    style: TextStyle(
                      color: Get.theme.colorScheme.primary,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RButton(
                    child: Text("login".tr),
                    onPressed: () {
                      Get.toNamed("login");
                    }),
                SizedBox(width: Get.width * 0.02),
                RButton(
                    child: Text("signup".tr),
                    onPressed: () {
                      Get.toNamed("signup");
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
