import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RFormFooter extends StatelessWidget {
  const RFormFooter({
    super.key,
    required this.label,
    required this.text,
    required this.onPressed,
  });

  final String label;
  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label),
        TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: Get.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: context.theme.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
