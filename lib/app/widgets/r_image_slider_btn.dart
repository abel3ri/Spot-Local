import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RImageSliderBtn extends StatelessWidget {
  const RImageSliderBtn({
    super.key,
    required this.onPressed,
    required this.alignment,
    required this.icon,
  });

  final Function() onPressed;
  final AlignmentGeometry alignment;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Align(
          alignment: alignment,
          child: Container(
            decoration: BoxDecoration(
              color: Get.theme.primaryColor,
              borderRadius: BorderRadius.circular(100),
            ),
            padding: const EdgeInsets.all(6),
            child: Icon(
              icon,
              size: 12,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
