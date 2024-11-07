import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:business_dir/app/modules/create_business/views/category_selection/views/category_selection_view.dart';
import 'package:business_dir/app/modules/create_business/views/pick_business_location_view.dart';
import 'package:business_dir/app/modules/create_business/views/widgets/r_city_drop_down.dart';
import 'package:business_dir/app/modules/create_business/views/widgets/r_select_image_container.dart';
import 'package:business_dir/app/modules/create_business/views/widgets/r_text_field_list.dart';
import 'package:business_dir/app/modules/image_picker/controllers/image_picker_controller.dart';
import 'package:business_dir/app/modules/image_picker/views/image_picker_view.dart';
import 'package:business_dir/app/widgets/r_button.dart';
import 'package:business_dir/app/widgets/r_chip.dart';
import 'package:business_dir/app/widgets/r_input_container.dart';
import 'package:business_dir/app/widgets/r_input_field_row.dart';
import 'package:business_dir/app/widgets/r_loading.dart';
import 'package:business_dir/app/widgets/r_picked_image_placeholder.dart';
import 'package:business_dir/app/widgets/r_stacked_image_container.dart';
import 'package:business_dir/app/widgets/r_text_icon_button.dart';
import 'package:business_dir/app/widgets/shimmers/r_circled_button.dart';
import 'package:business_dir/utils/form_validation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/create_business_controller.dart';

class CreateBusinessView extends GetView<CreateBusinessController> {
  CreateBusinessView({super.key});

  final imagePickController = Get.find<ImagePickerController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          "createBusiness".tr,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RPickedImagePlaceholder(
                imageType: "business_logo",
                label: "pickBusinessLogo".tr,
                placeholderText: "logo".tr,
                imagePath: imagePickController.businessLogoPath,
              ),
              SizedBox(height: Get.height * 0.02),
              RInputField(
                controller: controller.nameController,
                label: "businessName".tr,
                hintText: "enterBusinessName".tr,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: FormValidator.textValidtor,
              ),
              SizedBox(height: Get.height * 0.02),
              RInputField(
                controller: controller.licenseNumberController,
                label: "businessLicenseNumber".tr,
                hintText: "enterBusinessLicenseNumber".tr,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: FormValidator.licenseNumberValidator,
              ),
              SizedBox(height: Get.height * 0.02),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "businessLicenseImage".tr,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Obx(
                () {
                  if (imagePickController.businessLicenseImagePath.value !=
                      null) {
                    return Column(
                      children: [
                        SizedBox(height: Get.height * 0.01),
                        RStackedImageContainer(
                          imagePath: imagePickController
                              .businessLicenseImagePath.value!,
                          onFullScreenTap: () {
                            Get.toNamed("/image-preview", arguments: {
                              "imagePath": imagePickController
                                  .businessLicenseImagePath.value,
                            });
                          },
                          onCloseTap: () {
                            imagePickController.businessLicenseImagePath.value =
                                null;
                          },
                        ),
                        SizedBox(height: Get.height * 0.01),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
              SizedBox(height: Get.height * 0.01),
              RSelectImageContainer(
                onTap: () async {
                  showModalBottomSheet(
                    backgroundColor: Get.theme.scaffoldBackgroundColor,
                    context: context,
                    builder: (context) => ImagePickerView(
                      imageType: "business_license",
                      label: "pickBusinessLicense".tr,
                    ),
                    constraints: BoxConstraints(
                      maxHeight: Get.height * 0.3,
                    ),
                    showDragHandle: true,
                  );
                },
              ),
              SizedBox(height: Get.height * 0.02),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "businessCategory".tr,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              RInputContainer(
                onTap: () {
                  Get.to(() => CategorySelectionView());
                },
                label: "selectAllThatApplies".tr,
                trailing: Icon(
                  Icons.arrow_right_alt_rounded,
                  color: Get.theme.primaryColor,
                  size: 28,
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              Obx(
                () {
                  if (controller.selectedCategories.value.isNotEmpty) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        spacing: 4,
                        runSpacing: 2,
                        children: List.generate(
                          controller.selectedCategories.value.length,
                          (index) => Stack(
                            children: [
                              RChip(
                                label: controller
                                    .selectedCategories.value[index].name,
                              ),
                              Positioned(
                                top: 0,
                                right: -4,
                                child: RCircledButton(
                                  onTap: () {
                                    controller.selectedCategories.value
                                        .removeAt(index);
                                    controller.selectedCategories.refresh();
                                  },
                                  icon: Icons.close,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
              SizedBox(height: Get.height * 0.02),
              RInputField(
                controller: controller.descriptionController,
                label: "businessDescription".tr,
                hintText: "enterBusinessDescription".tr,
                maxLines: 4,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: FormValidator.textValidtor,
              ),
              SizedBox(height: Get.height * 0.02),
              RInputField(
                controller: controller.addressController,
                label: "businessAddress".tr,
                hintText: "enterBusinessAddress".tr,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: FormValidator.textValidtor,
              ),
              SizedBox(height: Get.height * 0.02),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "cityOfBusinessLocation".tr,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              Obx(
                () => RInputContainer(
                  label: controller.selectedCity.value != null
                      ? controller.selectedCity.value!.name!
                      : "selectCityWhereBusiness".tr,
                  trailing: RCityDropdown(),
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              RInputField(
                controller: controller.websiteController,
                label: '${"businessWebiste".tr} (${"optional".tr}',
                hintText: "enterBusinessWebsite".tr,
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.next,
                validator: FormValidator.urlValidator,
              ),
              SizedBox(height: Get.height * 0.02),
              RInputField(
                controller: controller.emailController,
                label: '${"businessEmail".tr} (${"optional".tr})',
                hintText: "enterBusinessEmail".tr,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) return null;
                  return FormValidator.emailValidator(value);
                },
              ),
              SizedBox(height: Get.height * 0.02),
              Obx(
                () => RTextFieldList(
                  controllers: controller.phoneControllers.value,
                  label: "businessPhone".tr,
                  hint: "enterBusinessPhone".tr,
                  validator: (value) {
                    if (value!.isEmpty) return null;
                    return FormValidator.phoneValidator(value);
                  },
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              RInputField(
                controller: controller.operationHoursController,
                label: '${"operationHours".tr} (${"optional".tr})',
                hintText: "enterOpeartionHours".tr,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: (value) => null,
              ),
              SizedBox(height: Get.height * 0.02),
              Obx(
                () => RTextFieldList(
                  controllers: controller.socialMediaControllers.value,
                  label: "socialMediaLink".tr,
                  hint: "enterSocialMedia".tr,
                  validator: FormValidator.urlValidator,
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${"uploadBusinessImages".tr} (${"optional".tr})',
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.005),
              RSelectImageContainer(
                onTap: () async {
                  final res = await imagePickController.pickMultipleImages();
                  res.fold((l) {
                    l.showError();
                  }, (r) {
                    imagePickController.businessImagesPath(
                      r.map((image) => image.path).toList(),
                    );
                  });
                },
              ),
              SizedBox(height: Get.height * 0.01),
              Obx(
                () {
                  if (imagePickController.businessImagesPath.value.isNotEmpty) {
                    return Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: List.generate(
                          imagePickController.businessImagesPath.value.length,
                          (index) {
                        return RStackedImageContainer(
                          imagePath: imagePickController
                              .businessImagesPath.value[index],
                          onCloseTap: () {
                            imagePickController.removeImage(index);
                          },
                          onFullScreenTap: () {
                            Get.toNamed("/image-preview", arguments: {
                              "imagePath": imagePickController
                                  .businessImagesPath.value[index],
                            });
                          },
                        );
                      }),
                    );
                  }
                  return const SizedBox();
                },
              ),
              SizedBox(height: Get.height * 0.01),
              Obx(() {
                if (controller.businessGeoCodedLocation.value != null) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "pickedLocation".tr,
                          style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.005),
                      Text(controller.businessGeoCodedLocation.value!),
                    ],
                  );
                }
                return const SizedBox();
              }),
              RTextIconButton(
                label: "pickBusinessLocaionOnMap".tr,
                icon: Icons.arrow_right_alt_rounded,
                onPressed: () {
                  Get.to(() => PickBusinessLocationView());
                },
              ),
              SizedBox(height: Get.height * 0.01),
              Obx(
                () => controller.isLoading.isFalse
                    ? RButton(
                        child: Text("create".tr),
                        onPressed: () async {
                          if (imagePickController
                                  .businessLicenseImagePath.value ==
                              null) {
                            AppErrorModel(
                              body: "pleasePorivdeBusinessLicenseImage".tr,
                            ).showError();
                            return;
                          }
                          if (controller.selectedCategories.value.isEmpty) {
                            AppErrorModel(
                              body: "pleaseSelectAtleastOneCat".tr,
                            ).showError();
                            return;
                          }
                          if (controller.selectedCity.value == null) {
                            AppErrorModel(
                              body: "pleaseSelectCity".tr,
                            ).showError();
                            return;
                          }
                          if (controller.businessLatLng.value == null) {
                            AppErrorModel(
                              body: "pleasePickLocationOnMap".tr,
                            ).showError();
                            return;
                          }
                          if (controller.formKey.currentState!.validate()) {
                            if (Get.focusScope?.hasFocus ?? false) {
                              Get.focusScope?.unfocus();
                            }
                            await controller.createBusiness();
                          }
                        },
                      )
                    : const RLoading(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
