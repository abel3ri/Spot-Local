import 'package:business_dir/app/widgets/r_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpAndSupportView extends GetView {
  const HelpAndSupportView({super.key});
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
          "helpAndSupport".tr,
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
              "weAreHereToAssist".tr,
              style: context.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            RCard(
              child: Column(
                children: [
                  RContactInfoRow(
                    label: "email".tr,
                    value: "info@etechsc.com",
                    onPressed: () async {
                      await launchUrl(Uri.parse("mailto:info@etechsc.com"));
                    },
                  ),
                  SizedBox(height: Get.height * 0.02),
                  RContactInfoRow(
                    label: "phone".tr,
                    value: "+251-118-22-04-22",
                    onPressed: () async {
                      await launchUrl(Uri.parse("tel:+251-118-22-04-22"));
                    },
                  ),
                  SizedBox(height: Get.height * 0.02),
                  RContactInfoRow(
                    label: "operatingHours".tr,
                    value: "24/7",
                    onPressed: null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RContactInfoRow extends StatelessWidget {
  const RContactInfoRow({
    super.key,
    required this.label,
    required this.value,
    required this.onPressed,
  });

  final String label;
  final String value;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        GestureDetector(
          onTap: onPressed,
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodyMedium!.copyWith(
              decoration: onPressed != null ? TextDecoration.underline : null,
              color: context.theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
