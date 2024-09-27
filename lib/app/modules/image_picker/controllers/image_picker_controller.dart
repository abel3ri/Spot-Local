import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  Future<Either<String, XFile>> pickImageFromCamera() async {
    try {
      XFile? image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 15);
      if (image == null) return left("No image selected.");
      return right(image);
    } catch (err) {
      throw left(err.toString());
    }
  }

  Future<Either<String, XFile>> pickImageFromGallery() async {
    try {
      XFile? image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 15);
      if (image == null) return left("No image selected.");
      return right(image);
    } catch (err) {
      throw left(err.toString());
    }
  }

  Future<Either<String, List<XFile>>> pickMultipleImages() async {
    try {
      List<XFile>? images =
          await ImagePicker().pickMultiImage(imageQuality: 15);
      if (images.isEmpty) return left("No images selected.");
      return right(images);
    } catch (err) {
      throw left(err.toString());
    }
  }
}
