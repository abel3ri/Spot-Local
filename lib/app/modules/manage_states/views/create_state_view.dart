import 'package:business_dir/app/modules/manage_states/controllers/manage_states_controller.dart';
import 'package:business_dir/app/widgets/r_button.dart';
import 'package:business_dir/app/widgets/r_input_field_row.dart';
import 'package:business_dir/app/widgets/r_loading.dart';
import 'package:business_dir/utils/form_validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateStateView extends GetView<ManageStatesController> {
  const CreateStateView({super.key});

  @override
  Widget build(BuildContext context) {
    final String title = Get.arguments['title'];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            controller.selectedState = null;
            controller.textEditingController.clear();
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          title,
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
                label: "stateName".tr,
                hintText: "enterStateName".tr,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                validator: FormValidator.cityValidator,
              ),
              SizedBox(height: Get.height * 0.02),
              Obx(
                () => controller.isLoading.isFalse
                    ? RButton(
                        child: Text(
                          title == "createState".tr ? "create".tr : "update".tr,
                        ),
                        onPressed: () async {
                          if (controller.formKey.currentState!.validate()) {
                            if (Get.focusScope?.hasFocus ?? false) {
                              Get.focusScope?.unfocus();
                            }
                            title == "createState".tr
                                ? await controller.createState()
                                : await controller.updateState();
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
