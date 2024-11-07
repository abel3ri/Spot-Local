import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RUserProfileText extends StatelessWidget {
  const RUserProfileText({
    super.key,
    this.isSuspended = false,
    required this.text,
    required this.label,
  });

  final bool isSuspended;
  final String text;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.textTheme.bodyMedium!.copyWith(
            color: isSuspended ? Colors.white : null,
          ),
        ),
        Text(
          text,
          style: context.textTheme.bodyMedium!.copyWith(
            color: isSuspended ? Colors.white : null,
            fontWeight: FontWeight.bold,
            decoration: label == "E-mail" ? TextDecoration.underline : null,
          ),
        ),
      ],
    );
  }
}
