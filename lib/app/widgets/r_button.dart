import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class RButton extends StatelessWidget {
  Widget child;
  Function()? onPressed;
  Color? color;
  RButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        fixedSize: const WidgetStatePropertyAll(Size(112, 16)),
        textStyle: WidgetStatePropertyAll(
          context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        backgroundColor: WidgetStatePropertyAll(color),
      ),
      child: child,
    );
  }
}
