import 'package:business_dir/app/widgets/r_alert_dialog.dart';
import 'package:flutter/material.dart';

class RSuspendAlert extends StatelessWidget {
  const RSuspendAlert({
    super.key,
    required this.onPressed,
  });

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return RAlertDialog(
      title: "Are your sure you want to suspend this user?",
      description: "Make sure to review the user carefully before you sespend.",
      btnLabel: "Suspend",
      onLabelBtnTap: onPressed,
    );
  }
}
