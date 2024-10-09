import 'package:flutter/material.dart';

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
      child: child,
    );
  }
}
