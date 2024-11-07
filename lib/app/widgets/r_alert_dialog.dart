import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RAlertDialog extends StatelessWidget {
  const RAlertDialog({
    super.key,
    required this.title,
    required this.description,
    required this.btnLabel,
    this.onLabelBtnTap,
  });

  final String title;
  final String description;
  final String btnLabel;
  final Function()? onLabelBtnTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: Text(description),
      actions: [
        TextButton(
          onPressed: onLabelBtnTap,
          style: ButtonStyle(
            textStyle: WidgetStatePropertyAll(
              context.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          child: Text(
            btnLabel,
          ),
        ),
        TextButton(
          style: ButtonStyle(
            textStyle: WidgetStatePropertyAll(
              context.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          onPressed: () {
            Get.back();
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
