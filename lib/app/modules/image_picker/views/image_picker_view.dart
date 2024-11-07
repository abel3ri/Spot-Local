import 'package:business_dir/app/widgets/r_list_tile.dart';
import 'package:business_dir/app/widgets/r_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/image_picker_controller.dart';

class ImagePickerView extends GetView<ImagePickerController> {
  const ImagePickerView({
    super.key,
    this.imageType,
    this.label,
  });
  final String? imageType;
  final String? label;
  @override
  Widget build(BuildContext context) {
    return RModalBottomSheet(
      label: label ?? "Pick Profile Image",
      children: [
        RListTile(
          title: "gallery".tr,
          leadingIcon: Icons.image,
          onPressed: () async {
            final res = await controller.pickImageFromGallery();
            res.fold((l) {
              l.showError();
            }, (r) {
              if (imageType == "profile_image") {
                controller.profileImagePath(r.path);
              } else if (imageType == "business_license") {
                controller.businessLicenseImagePath(r.path);
              } else if (imageType == "business_logo") {
                controller.businessLogoPath(r.path);
              }
              controller.update();
              Get.back();
            });
          },
        ),
        RListTile(
          title: "camera".tr,
          leadingIcon: Icons.camera,
          onPressed: () async {
            final res = await controller.pickImageFromCamera();
            res.fold((l) {
              l.showError();
            }, (r) {
              if (imageType == "profile_image") {
                controller.profileImagePath(r.path);
              } else if (imageType == "business_license") {
                controller.businessLicenseImagePath(r.path);
              } else if (imageType == "business_logo") {
                controller.businessLogoPath(r.path);
              }
              Get.back();
            });
          },
        ),
      ],
    );
  }
}
