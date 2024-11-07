import 'dart:io';

import 'package:business_dir/app/data/models/business_model.dart';
import 'package:business_dir/app/data/models/category_model.dart';
import 'package:business_dir/app/data/models/city_model.dart';
import 'package:business_dir/app/data/providers/business_provider.dart';
import 'package:business_dir/app/data/providers/city_provider.dart';
import 'package:business_dir/app/modules/image_picker/controllers/image_picker_controller.dart';
import 'package:business_dir/app/modules/my_businesses/controllers/my_businesses_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';
import "package:path/path.dart" as p;
import 'package:http/http.dart' as http;

class EditBusinessController extends GetxController {
  Rx<List<TextEditingController>> socialMediaControllers =
      Rx<List<TextEditingController>>([]);
  Rx<List<TextEditingController>> phoneControllers =
      Rx<List<TextEditingController>>([]);
  TextEditingController nameController = TextEditingController();
  TextEditingController licenseNumberController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController operationHoursController = TextEditingController();

  Rx<List<CategoryModel>> selectedCategories = Rx<List<CategoryModel>>([]);
  Rx<String?> businessGeoCodedLocation = Rx<String?>(null);
  Rx<LatLng?> businessLatLng = Rx<LatLng?>(null);
  final formKey = GlobalKey<FormState>();
  Rx<bool> isLoading = false.obs;
  Rx<bool> isCitiesLoading = false.obs;
  late BusinessProvider businessProvider;
  late CityProvider cityProvider;
  late MyBusinessesController myBusinessesController;

  Rx<List<CityModel>> cities = Rx<List<CityModel>>([]);
  Rx<CityModel?> selectedCity = Rx<CityModel?>(null);

  @override
  void onInit() {
    super.onInit();
    cityProvider = Get.find<CityProvider>();
    businessProvider = Get.find<BusinessProvider>();
    myBusinessesController = Get.find<MyBusinessesController>();

    addSocialMediaLinkField();
    addPhoneField();
    initControllers();
    getAllCities();
  }

  void addSocialMediaLinkField() {
    socialMediaControllers.value.add(TextEditingController());
    socialMediaControllers.refresh();
  }

  void addPhoneField() {
    phoneControllers.value.add(TextEditingController());
    phoneControllers.refresh();
  }

  void removeSocialMediaField(int index) {
    socialMediaControllers.value.removeAt(index);
    socialMediaControllers.refresh();
  }

  void removePhoneField(int index) {
    phoneControllers.value.removeAt(index);
    phoneControllers.refresh();
  }

  void setBusinessCoords(LatLng coords) {
    businessLatLng.value = coords;
  }

  Future<void> editBusiness() async {
    final imagePickController = Get.find<ImagePickerController>();
    isLoading(true);
    final Map<String, dynamic> businessData = {
      "name": nameController.text,
      "description": descriptionController.text,
      "licenseNumber": licenseNumberController.text,
      "operationHours": operationHoursController.text,
      "address": addressController.text,
      "phone": phoneControllers.value.isNotEmpty
          ? phoneControllers.value.map((phone) => phone.text).toList()
          : null,
      "email": emailController.text.isNotEmpty ? emailController.text : null,
      "website":
          websiteController.text.isNotEmpty ? websiteController.text : null,
      "latLng": [
        businessLatLng.value!.latitude,
        businessLatLng.value!.longitude
      ],
      "cityId": selectedCity.value!.id,
      "categories":
          selectedCategories.value.map((category) => category.id).toList(),
      "socialMedia": socialMediaControllers.value.isNotEmpty
          ? socialMediaControllers.value.map((social) => social.text).toList()
          : null,
    };

    if (imagePickController.businessLogoPath.value != null) {
      final logoFile =
          await fileFromImageUrl(imagePickController.businessLogoPath.value!);
      businessData["business_logo"] = logoFile;
    } else {
      businessData["business_logo"] = null;
    }

    if (imagePickController.businessLicenseImagePath.value != null) {
      final licenseFile = await fileFromImageUrl(
          imagePickController.businessLicenseImagePath.value!);
      businessData["business_license"] = licenseFile;
    } else {
      businessData["business_license"] = null;
    }

    if (imagePickController.businessImagesPath.value.isNotEmpty) {
      final imageFiles = await Future.wait(
        imagePickController.businessImagesPath.value.map((imagePath) async {
          return await fileFromImageUrl(imagePath);
        }),
      );
      businessData["business_images"] = imageFiles.whereType<File>().toList();
    } else {
      businessData["business_images"] = null;
    }

    final res = await businessProvider.updateOne(
      businessId: myBusinessesController.selectedBusiness.value!.id!,
      businessData: businessData,
    );
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) {
      myBusinessesController.pagingController.refresh();
      Get.back();
    });
  }

  Future<void> getAddressFromLatLng() async {
    try {
      final List<Placemark> placeMark = await placemarkFromCoordinates(
        businessLatLng.value!.latitude,
        businessLatLng.value!.longitude,
      );
      businessGeoCodedLocation.value =
          '${placeMark.first.name}, ${placeMark.first.locality}, ${placeMark.first.country}';
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getAllCities() async {
    isCitiesLoading.value = true;
    final res = await cityProvider.findAll();
    isCitiesLoading.value = false;
    res.fold((l) {
      l.showError();
    }, (r) {
      cities.value = r;
    });
  }

  void initControllers() {
    final imagePickController = Get.find<ImagePickerController>();
    final BusinessModel? selectedBusiness =
        myBusinessesController.selectedBusiness.value;
    if (selectedBusiness == null) return;

    nameController.text = selectedBusiness.name ?? '';
    licenseNumberController.text = selectedBusiness.licenseNumber ?? '';
    selectedCategories.value = selectedBusiness.categories ?? [];
    descriptionController.text = selectedBusiness.description ?? '';
    addressController.text = selectedBusiness.address ?? '';
    selectedCity.value = selectedBusiness.city;
    websiteController.text = selectedBusiness.website ?? '';
    emailController.text = selectedBusiness.email ?? '';
    phoneControllers.value = List.generate(
      selectedBusiness.phone?.length ?? 0,
      (index) => TextEditingController(text: selectedBusiness.phone![index]),
    );

    socialMediaControllers.value = List.generate(
      selectedBusiness.socialMedia?.length ?? 0,
      (index) =>
          TextEditingController(text: selectedBusiness.socialMedia![index]),
    );

    businessLatLng.value = selectedBusiness.latLng;
    getAddressFromLatLng();

    if (selectedBusiness.images != null) {
      imagePickController.businessImagesPath.value =
          List.generate(selectedBusiness.images?.length ?? 0, (index) {
        return selectedBusiness.images![index]!['url'];
      });
    }
    if (selectedBusiness.businessLicense != null) {
      imagePickController.businessLicenseImagePath.value =
          selectedBusiness.businessLicense!['url'];
    }

    update();
  }

  Future<File?> fileFromImageUrl(String imageUrl) async {
    try {
      if (imageUrl.isEmpty) {
        return null;
      }

      if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
        final response = await http.get(Uri.parse(imageUrl));
        if (response.statusCode == 200) {
          final documentDirectory = await getApplicationDocumentsDirectory();
          final fileName = p.basename(imageUrl);
          final file = File(p.join(documentDirectory.path, fileName));
          await file.writeAsBytes(response.bodyBytes);
          return file;
        } else {
          return null;
        }
      }

      if (imageUrl.contains("assets/image")) {
        final byteData = await rootBundle.load(imageUrl);
        final fileName = p.basename(imageUrl);
        final file = File('${(await getTemporaryDirectory()).path}/$fileName');
        await file.create(recursive: true);
        await file.writeAsBytes(
          byteData.buffer.asUint8List(
            byteData.offsetInBytes,
            byteData.lengthInBytes,
          ),
        );
        return file;
      }
      return File(imageUrl);
    } catch (e) {
      return null;
    }
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    licenseNumberController.dispose();
    descriptionController.dispose();
    addressController.dispose();
    websiteController.dispose();
    emailController.dispose();
    operationHoursController.dispose();
    for (var controller in socialMediaControllers.value) {
      controller.dispose();
    }
    for (var controller in phoneControllers.value) {
      controller.dispose();
    }
  }
}
