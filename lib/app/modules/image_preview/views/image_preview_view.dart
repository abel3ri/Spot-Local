import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../controllers/image_preview_controller.dart';

class ImagePreviewView extends GetView<ImagePreviewController> {
  const ImagePreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final String imagePath = Get.arguments['imagePath'];

    ImageProvider imageProvider;
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      imageProvider = NetworkImage(imagePath);
    } else if (imagePath.startsWith('assets/')) {
      imageProvider = AssetImage(imagePath);
    } else {
      imageProvider = FileImage(File(imagePath));
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          "imagePreview".tr,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: PhotoView(
          imageProvider: imageProvider,
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
          heroAttributes: PhotoViewHeroAttributes(tag: imagePath),
          errorBuilder: (context, error, stackTrace) {
            return Image.asset("assets/image.png");
          },
        ),
      ),
    );
  }
}
