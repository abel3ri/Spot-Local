import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RTextIconButton extends StatelessWidget {
  const RTextIconButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.icon,
    this.textStyle,
    this.color,
  });

  final void Function()? onPressed;
  final String label;
  final IconData icon;
  final TextStyle? textStyle;
  final Color? color;

  RTextIconButton.medium({
    super.key,
    required this.label,
    required this.onPressed,
    required this.icon,
    this.color,
  }) : textStyle = Get.textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.bold,
        );
  RTextIconButton.small({
    super.key,
    required this.label,
    required this.onPressed,
    required this.icon,
    this.color,
  }) : textStyle = Get.textTheme.bodySmall!.copyWith(
          fontWeight: FontWeight.bold,
        );

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          textStyle ??
              context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        foregroundColor: WidgetStatePropertyAll(color),
      ),
      label: Text(label),
      iconAlignment: IconAlignment.end,
      icon: Icon(
        icon,
        color: color,
      ),
    );
  }
}
