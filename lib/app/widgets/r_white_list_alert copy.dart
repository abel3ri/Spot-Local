import 'package:business_dir/app/widgets/r_alert_dialog.dart';
import 'package:flutter/material.dart';

class RWhiteListAlert extends StatelessWidget {
  const RWhiteListAlert({
    super.key,
    required this.onPressed,
  });

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return RAlertDialog(
      title: "Are your sure you want to whitelist this user?",
      description:
          "Make sure to review the user carefully before you whitelist.",
      btnLabel: "Whitelist",
      onLabelBtnTap: onPressed,
    );
  }
}
