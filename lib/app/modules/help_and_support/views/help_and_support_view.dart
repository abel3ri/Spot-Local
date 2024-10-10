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
          "Help and Support",
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
              "We're here to assist you with any questions or issues you may have while using the app. If you need assistance, feel free to reach out to us:",
              style: Get.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            RCard(
              child: Column(
                children: [
                  RContactInfoRow(
                    label: "E-mail",
                    value: "info@etechsc.com",
                    onPressed: () async {
                      await launchUrl(Uri.parse("mailto:info@etechsc.com"));
                    },
                  ),
                  SizedBox(height: Get.height * 0.02),
                  RContactInfoRow(
                    label: "Phone",
                    value: "+251-118-22-04-22",
                    onPressed: () async {
                      await launchUrl(Uri.parse("tel:+251-118-22-04-22"));
                    },
                  ),
                  SizedBox(height: Get.height * 0.02),
                  RContactInfoRow(
                    label: "Operating Hours",
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
            style: Get.textTheme.bodyMedium!.copyWith(
              decoration: onPressed != null ? TextDecoration.underline : null,
              color: context.theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
