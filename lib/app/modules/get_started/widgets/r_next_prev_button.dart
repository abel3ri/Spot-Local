import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RNextPrevButton extends StatelessWidget {
  const RNextPrevButton({
    super.key,
    required this.isVisible,
    required this.icon,
    required this.onPressed,
  });

  final bool isVisible;
  final Function()? onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Align(
        alignment: Alignment.centerRight,
        child: FadeIn(
          animate: true,
          duration: Duration(seconds: 3),
          child: IconButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Get.theme.primaryColor),
              padding: WidgetStatePropertyAll(EdgeInsets.all(16)),
              iconColor: WidgetStatePropertyAll(Colors.white),
            ),
            onPressed: onPressed,
            icon: Icon(icon),
          ),
        ),
      ),
    );
  }
}
