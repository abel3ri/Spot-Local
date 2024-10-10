import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  Rx<String?> imagePath = Rx<String?>(null);
  Rx<List<String>> imagePaths = Rx<List<String>>([]);
  Future<Either<AppErrorModel, void>> pickImageFromCamera() async {
    try {
      XFile? image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 15);
      if (image == null) return left(AppErrorModel(body: "No image selected!"));
      imagePath.value = image.path;
      return right(image);
    } catch (err) {
      throw left(err.toString());
    }
  }

  Future<Either<AppErrorModel, void>> pickImageFromGallery() async {
    try {
      XFile? image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 15);
      if (image == null) return left(AppErrorModel(body: "No image selected!"));
      imagePath.value = image.path;
      return right(null);
    } catch (err) {
      throw left(err.toString());
    }
  }

  Future<Either<AppErrorModel, void>> pickMultipleImages() async {
    try {
      List<XFile>? images =
          await ImagePicker().pickMultiImage(imageQuality: 15);
      if (images.isEmpty)
        return left(AppErrorModel(body: "No image selected!"));
      imagePaths.value = images.map((image) => image.path).toList();
      return right(null);
    } catch (err) {
      throw left(err.toString());
    }
  }
}
