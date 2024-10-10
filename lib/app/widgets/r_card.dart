import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RCard extends StatelessWidget {
  const RCard({
    super.key,
    required this.child,
    this.color,
  });

  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color ?? context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Get.isDarkMode ? Colors.black26 : Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
