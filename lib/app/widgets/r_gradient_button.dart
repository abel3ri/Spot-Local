import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RGradientButton extends StatelessWidget {
  const RGradientButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: onPressed != null
                ? [
                    context.theme.colorScheme.primary.withOpacity(.7),
                    context.theme.colorScheme.primary,
                  ]
                : [Colors.grey, Colors.grey.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: context.textTheme.bodyLarge!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
