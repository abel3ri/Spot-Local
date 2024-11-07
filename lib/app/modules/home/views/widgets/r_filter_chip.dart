import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RFilterChip extends StatelessWidget {
  const RFilterChip({
    super.key,
    required this.label,
    required this.onChanged,
    required this.selected,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(brightness: Brightness.dark),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: onChanged,
        selectedColor: Get.theme.primaryColor,
        labelStyle: context.textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.bold,
          color: selected ? Colors.white : null,
        ),
        backgroundColor: selected
            ? Get.theme.primaryColor
            : context.theme.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide.none,
        ),
      ),
    );
  }
}
