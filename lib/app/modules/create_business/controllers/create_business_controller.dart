import 'dart:io';

import 'package:business_dir/app/data/models/category_model.dart';
import 'package:business_dir/app/data/models/city_model.dart';
import 'package:business_dir/app/data/providers/business_provider.dart';
import 'package:business_dir/app/data/providers/city_provider.dart';
import 'package:business_dir/app/modules/image_picker/controllers/image_picker_controller.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class CreateBusinessController extends GetxController {
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
  Rx<List<CityModel>> cities = Rx<List<CityModel>>([]);
  Rx<CityModel?> selectedCity = Rx<CityModel?>(null);

  @override
  void onInit() {
    super.onInit();
    cityProvider = Get.find<CityProvider>();
    businessProvider = Get.find<BusinessProvider>();
    addSocialMediaLinkField();
    addPhoneField();
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

  Future<void> createBusiness() async {
    final imagePickController = Get.find<ImagePickerController>();
    final Map<String, dynamic> businessData = {
      "name": nameController.text,
      "description": descriptionController.text,
      "licenseNumber": licenseNumberController.text,
      "operationHours": operationHoursController.text,
      "address": addressController.text,
      "phone": phoneControllers.value.first.text.isNotEmpty
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
      "socialMedia": socialMediaControllers.value.first.text.isNotEmpty
          ? socialMediaControllers.value.map((social) => social.text).toList()
          : null,
      "business_images": imagePickController.businessImagesPath.value.isNotEmpty
          ? imagePickController.businessImagesPath.value
              .map((image) => File(image))
              .toList()
          : null,
      "business_logo": imagePickController.businessLogoPath.value != null
          ? File(imagePickController.businessLogoPath.value!)
          : null,
      "business_license":
          imagePickController.businessLicenseImagePath.value != null
              ? File(imagePickController.businessLicenseImagePath.value!)
              : null,
    };
    isLoading(true);
    final res = await businessProvider.create(businessData: businessData);
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) {
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
    } catch (e) {}
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
