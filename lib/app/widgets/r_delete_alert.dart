import 'package:business_dir/app/widgets/r_alert_dialog.dart';
import 'package:flutter/material.dart';

class RDeleteAlert extends StatelessWidget {
  const RDeleteAlert({
    super.key,
    required this.onPressed,
    required this.itemType,
  });

  final Function() onPressed;
  final String itemType;

  @override
  Widget build(BuildContext context) {
    return RAlertDialog(
      title: "Are your sure you want to delete this $itemType?",
      description:
          "Make sure to review the $itemType carefully before you delete. Deleting the $itemType will remove all of its associated models!",
      btnLabel: "Delete",
      onLabelBtnTap: onPressed,
    );
  }
}
