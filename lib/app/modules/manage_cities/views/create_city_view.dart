import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:business_dir/app/widgets/r_button.dart';
import 'package:business_dir/app/widgets/r_input_container.dart';
import 'package:business_dir/app/widgets/r_input_field_row.dart';
import 'package:business_dir/app/widgets/r_loading.dart';
import 'package:business_dir/utils/form_validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:business_dir/app/modules/manage_cities/controllers/manage_cities_controller.dart';

class CreateCityView extends GetView<ManageCitiesController> {
  const CreateCityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            controller.clearForm();
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          "createCity".tr,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              RInputField(
                controller: controller.textEditingController,
                label: "cityName".tr,
                hintText: "enterCityName".tr,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                validator: FormValidator.cityValidator,
              ),
              SizedBox(height: Get.height * 0.02),
              Obx(
                () => RInputContainer(
                  label: controller.selectedState.value == null
                      ? "enterCityState".tr
                      : "${"selectedState".tr}- ${controller.selectedState.value?.name}",
                  trailing: Obx(
                    () {
                      if (controller.isLoading.isTrue) {
                        return const SizedBox(
                            width: 48, height: 48, child: RLoading());
                      }
                      if (controller.states.value.isEmpty) {
                        return Center(
                          child: Text("noStateFound".tr),
                        );
                      }
                      return DropdownButton(
                        items: List.generate(controller.states.value.length,
                            (index) {
                          final state = controller.states.value[index];
                          return DropdownMenuItem(
                            value: state,
                            child: Text(state.name!),
                          );
                        }),
                        borderRadius: BorderRadius.circular(8),
                        disabledHint: Text("selectState".tr),
                        hint: Text("selectState".tr),
                        underline: const SizedBox.shrink(),
                        value: controller.selectedState.value,
                        alignment: Alignment.centerRight,
                        style: context.textTheme.bodyMedium,
                        onChanged: (value) {
                          controller.selectedState.value = value;
                        },
                        icon: const Icon(Icons.arrow_right_alt_rounded),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              Obx(
                () => controller.isLoading.isFalse
                    ? RButton(
                        child: Text("create".tr),
                        onPressed: () async {
                          if (controller.formKey.currentState!.validate()) {
                            if (controller.selectedState.value == null) {
                              AppErrorModel(body: "pleaseSelectState".tr)
                                  .showError();
                              return;
                            }
                            if (Get.focusScope?.hasFocus ?? false) {
                              Get.focusScope?.unfocus();
                            }
                            await controller.createCity();
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
