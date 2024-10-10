import 'package:business_dir/app/widgets/r_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSuccessModel {
  const AppSuccessModel({
    required this.body,
  });

  final String body;

  void showSuccess() {
    Get.closeAllSnackbars();
    Get.showSnackbar(
      GetSnackBar(
        duration: const Duration(seconds: 3),
        animationDuration: const Duration(milliseconds: 500),
        dismissDirection: DismissDirection.horizontal,
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: Colors.transparent,
        messageText: RCard(
          color: Colors.green,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                body,
                style: Get.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
