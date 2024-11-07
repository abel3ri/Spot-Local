import 'package:business_dir/app/widgets/r_text_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RSelectImageContainer extends StatelessWidget {
  const RSelectImageContainer({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Get.theme.colorScheme.primary,
          width: 1.5,
        ),
      ),
      width: Get.width,
      height: 64,
      child: RTextIconButton(
        label: "select".tr,
        onPressed: onTap,
        icon: Icons.add,
      ),
    );
  }
}
