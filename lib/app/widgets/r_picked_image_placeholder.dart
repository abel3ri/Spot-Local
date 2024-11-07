import 'dart:io';

import 'package:business_dir/app/modules/edit_profile/views/widgets/r_circular_fade_in_asset_image.dart';
import 'package:business_dir/app/modules/image_picker/views/image_picker_view.dart';
import 'package:business_dir/app/widgets/shimmers/r_circled_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class RPickedImagePlaceholder extends StatelessWidget {
  RPickedImagePlaceholder({
    super.key,
    required this.imagePath,
    required this.label,
    required this.imageType,
    required this.placeholderText,
    this.currentImageUrl,
  });

  Rx<String?> imagePath;
  final String placeholderText;
  final String label;
  final String imageType;
  final String? currentImageUrl;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          if (imagePath.value != null)
            CircleAvatar(
              radius: 48,
              backgroundImage: FileImage(
                File(imagePath.value!),
              ),
            )
          else if (currentImageUrl != null)
            RCircularFadeInAssetNetworkImage(
              imagePath: currentImageUrl!,
            )
          else
            CircleAvatar(
              radius: 48,
              child: Text(placeholderText),
            ),
          Positioned(
            bottom: 4,
            right: 0,
            child: RCircledButton.small(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Get.theme.scaffoldBackgroundColor,
                  context: context,
                  builder: (context) => ImagePickerView(
                    imageType: imageType,
                    label: label,
                  ),
                  constraints: BoxConstraints(
                    maxHeight: Get.height * 0.3,
                  ),
                  showDragHandle: true,
                );
              },
              icon: Icons.add_rounded,
            ),
          ),
          if (imagePath.value != null)
            Positioned(
              bottom: 4,
              left: 0,
              child: RCircledButton.small(
                onTap: () {
                  imagePath.value = null;
                },
                icon: Icons.close,
              ),
            ),
        ],
      ),
    );
  }
}
