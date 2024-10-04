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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        duration: const Duration(seconds: 3),
        animationDuration: const Duration(milliseconds: 500),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        borderRadius: 4,
        dismissDirection: DismissDirection.horizontal,
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: Colors.green,
        messageText: Padding(
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
    );
  }
}
