import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RPopupMenuBtn extends StatelessWidget {
  const RPopupMenuBtn({
    super.key,
    required this.children,
    required this.initialValue,
    this.isEnabled = true,
    required this.onSelected,
  });

  final List<PopupMenuEntry<String>> children;
  final Function(String onSelected)? onSelected;
  final bool isEnabled;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: context.theme.scaffoldBackgroundColor,
      position: PopupMenuPosition.under,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      icon: const Icon(Icons.tune_rounded),
      initialValue: initialValue,
      itemBuilder: (context) => children,
      onSelected: onSelected,
      enabled: isEnabled,
    );
  }
}
