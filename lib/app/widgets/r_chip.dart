import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RChip extends StatelessWidget {
  const RChip({
    super.key,
    required this.label,
    this.color,
    this.onTap,
  });

  final String label;
  final Color? color;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        padding: const EdgeInsets.only(right: 4),
        shape: const StadiumBorder(
          side: BorderSide(
            color: Colors.transparent,
          ),
        ),
        backgroundColor: color ?? context.theme.primaryColor,
        labelStyle: context.textTheme.bodyMedium!.copyWith(
          color: Colors.white,
        ),
        label: Text(label),
      ),
    );
  }
}
