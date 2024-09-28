import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class RButton extends StatelessWidget {
  Widget child;
  Function()? onPressed;
  RButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        fixedSize: WidgetStatePropertyAll(Size(112, 16)),
      ),
      child: child.runtimeType == Text
          ? Text(
              (child as Text).data!,
              style: Get.textTheme.bodyMedium!.copyWith(
                color: Colors.white,
              ),
            )
          : child,
    );
  }
}
