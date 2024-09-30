import 'package:business_dir/app/widgets/r_list_tile.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/image_picker_controller.dart';

class ImagePickerView extends GetView<ImagePickerController> {
  const ImagePickerView({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Text(
          "Pick Profile Image",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(),
        ),
        RListTile(
          title: "Gallery",
          leadingIcon: Icons.image,
          onPressed: () async {
            final res = await controller.pickImageFromGallery();
            res.fold((l) {
              l.showError();
            }, (r) {
              Get.back();
            });
          },
        ),
        RListTile(
          title: "Camera",
          leadingIcon: Icons.camera,
          onPressed: () async {
            final res = await controller.pickImageFromCamera();
            res.fold((l) {
              l.showError();
            }, (r) {
              Get.back();
            });
          },
        ),
        RListTile(
          title: "Cancel",
          leadingIcon: Icons.close,
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }
}
