import 'dart:io';

import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImagePickerController extends GetxController {
  Rx<List<String>> businessImagesPath = Rx<List<String>>([]);
  Rx<String?> profileImagePath = Rx<String?>(null);
  Rx<String?> businessLogoPath = Rx<String?>(null);
  Rx<String?> businessLicenseImagePath = Rx<String?>(null);

  void removeImage(index) {
    businessImagesPath.value.removeAt(index);
    businessImagesPath.refresh();
  }

  Future<Either<AppErrorModel, File>> pickImageFromCamera() async {
    try {
      XFile? pickedFile = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 15);
      if (pickedFile == null)
        return left(AppErrorModel(body: "No image selected!"));

      final appDocDir = await getTemporaryDirectory();
      final fileName = pickedFile.path.split('/').last;
      final savedImage = await File('${appDocDir.path}/$fileName')
          .writeAsBytes(await pickedFile.readAsBytes());
      return right(savedImage);
    } catch (err) {
      throw left(err.toString());
    }
  }

  Future<Either<AppErrorModel, File>> pickImageFromGallery() async {
    try {
      XFile? pickedFile = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 15);
      if (pickedFile == null)
        return left(AppErrorModel(body: "No image selected!"));

      final appDocDir = await getTemporaryDirectory();
      final fileName = pickedFile.path.split('/').last;
      final savedImage = await File('${appDocDir.path}/$fileName')
          .writeAsBytes(await pickedFile.readAsBytes());
      return right(savedImage);
    } catch (err) {
      throw left(err.toString());
    }
  }

  Future<Either<AppErrorModel, List<XFile>>> pickMultipleImages() async {
    try {
      final List<XFile>? images = await ImagePicker().pickMultiImage(
        imageQuality: 80,
        limit: 5,
      );

      if (images == null || images.isEmpty) {
        return left(AppErrorModel(body: "No image selected!"));
      }

      List<XFile> compressedImages = [];

      final tempDir = await getTemporaryDirectory();

      for (var image in images) {
        final compressedBytes = await FlutterImageCompress.compressWithFile(
          image.path,
          quality: 85,
          minWidth: 600,
          minHeight: 600,
        );

        if (compressedBytes != null) {
          final compressedFilePath = '${tempDir.path}/${image.name}';
          final compressedFile =
              await File(compressedFilePath).writeAsBytes(compressedBytes);

          compressedImages.add(XFile(compressedFile.path));
        }
      }

      return right(compressedImages);
    } catch (err) {
      return left(AppErrorModel(body: err.toString()));
    }
  }
}
