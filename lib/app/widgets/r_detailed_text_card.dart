import 'package:business_dir/app/widgets/r_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RDetailedTextCard extends StatelessWidget {
  const RDetailedTextCard({
    super.key,
    required this.heading,
    required this.body,
  });

  final String heading;
  final String body;

  @override
  Widget build(BuildContext context) {
    return RCard(
      child: Text.rich(
        TextSpan(
          text: heading,
          style: Get.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: body,
              style: Get.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
