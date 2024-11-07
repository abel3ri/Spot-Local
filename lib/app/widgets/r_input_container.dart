import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RInputContainer extends StatelessWidget {
  const RInputContainer({
    super.key,
    required this.label,
    this.trailing,
    this.onTap,
  });

  final String label;
  final Widget? trailing;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Get.theme.primaryColor,
            width: 1.8,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                label,
                style:
                    context.textTheme.bodyLarge!.copyWith(color: Colors.grey),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (trailing != null) trailing!
          ],
        ),
      ),
    );
  }
}
