import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RContactInfoRow extends StatelessWidget {
  const RContactInfoRow({
    super.key,
    required this.child,
    required this.icon,
  });

  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 32,
          color: Get.theme.primaryColor,
        ),
        SizedBox(width: Get.width * 0.03),
        child,
      ],
    );
  }
}
