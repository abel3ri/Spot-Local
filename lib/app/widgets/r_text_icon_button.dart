import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RTextIconButton extends StatelessWidget {
  const RTextIconButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.icon,
  });

  final Function() onPressed;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          Get.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      label: Text(
        label,
      ),
      iconAlignment: IconAlignment.end,
      icon: Icon(icon),
    );
  }
}
