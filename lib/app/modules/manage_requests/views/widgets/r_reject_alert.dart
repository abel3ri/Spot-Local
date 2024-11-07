import 'package:business_dir/app/modules/manage_requests/controllers/manage_requests_controller.dart';
import 'package:business_dir/app/widgets/r_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RRejectAlert extends StatelessWidget {
  const RRejectAlert({
    super.key,
    required this.requestId,
  });
  final String requestId;

  @override
  Widget build(BuildContext context) {
    return RAlertDialog(
      title: "Are you sure you want to reject the request?",
      description:
          "Make sure you review the request thoroughly before you reject.",
      btnLabel: "Reject",
      onLabelBtnTap: () async {
        Get.back();
        await Get.find<ManageRequestsController>().updateRequest(
          requestId: requestId,
          requestData: {"status": "rejected"},
        );
      },
    );
  }
}
