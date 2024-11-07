import 'package:business_dir/app/widgets/r_alert_dialog.dart';
import 'package:flutter/material.dart';

class RSuspendAlert extends StatelessWidget {
  const RSuspendAlert({
    super.key,
    required this.onPressed,
    required this.itemType,
  });

  final Function() onPressed;
  final String itemType;

  @override
  Widget build(BuildContext context) {
    return RAlertDialog(
      title: "Are your sure you want to suspend this $itemType?",
      description:
          "Make sure to review the $itemType carefully before you sespend.",
      btnLabel: "Suspend",
      onLabelBtnTap: onPressed,
    );
  }
}
