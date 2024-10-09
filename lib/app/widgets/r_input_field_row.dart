import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RInputField extends StatelessWidget {
  const RInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.keyboardType,
    required this.textInputAction,
    required this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String label;
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Widget? suffixIcon;
  final String? Function(String? value) validator;
  final bool obscureText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: Get.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: Get.height * 0.005),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          textInputAction: textInputAction,
          obscureText: obscureText,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: Get.textTheme.bodyLarge!.copyWith(
              color: Colors.grey.shade500,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: context.theme.colorScheme.primary,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: context.theme.colorScheme.primary,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: context.theme.colorScheme.primary,
                width: 1.5,
              ),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
