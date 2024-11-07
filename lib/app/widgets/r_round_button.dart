import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RRoundedButton extends StatelessWidget {
  const RRoundedButton({
    super.key,
    required this.label,
    this.color,
    required this.onPressed,
  });

  final String label;
  final Color? color;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        // backgroundColor: WidgetStatePropertyAll(color),
        padding: const WidgetStatePropertyAll(EdgeInsets.all(0)),
        maximumSize: const WidgetStatePropertyAll(Size.fromHeight(40)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: context.textTheme.bodySmall!.copyWith(
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
