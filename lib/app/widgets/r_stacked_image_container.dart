import 'dart:io';

import 'package:business_dir/app/widgets/shimmers/r_circled_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RStackedImageContainer extends StatelessWidget {
  const RStackedImageContainer({
    super.key,
    required this.imagePath,
    required this.onFullScreenTap,
    required this.onCloseTap,
  });

  final String imagePath;
  final Function() onFullScreenTap;
  final Function() onCloseTap;

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      imageProvider = NetworkImage(imagePath);
    } else {
      imageProvider = FileImage(File(imagePath));
    }

    return Stack(
      alignment: Alignment.topRight,
      children: [
        SizedBox(
          width: Get.width * 0.4,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image(
              image: imageProvider,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                "assets/image.png",
              ),
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: RCircledButton(
            onTap: onCloseTap,
            icon: Icons.close,
          ),
        ),
        Positioned(
          top: 4,
          left: 4,
          child: RCircledButton(
            onTap: onFullScreenTap,
            icon: Icons.fullscreen_rounded,
          ),
        ),
      ],
    );
  }
}
