import 'package:business_dir/app/modules/edit_business/controllers/edit_business_controller.dart';
import 'package:business_dir/app/widgets/r_input_field_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RTextFieldList extends StatelessWidget {
  final controller = Get.find<EditBusinessController>();
  RTextFieldList({
    super.key,
    required this.controllers,
    required this.hint,
    required this.label,
    required this.validator,
  });

  final List<TextEditingController> controllers;
  final String label;
  final String hint;
  final String? Function(String? value) validator;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controllers.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            RInputField(
              controller: controllers[index],
              label: "$label ${index + 1} (Optional)",
              hintText: "$hint ${index + 1}",
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              validator: validator,
            ),
            SizedBox(height: Get.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (index != 0)
                  GestureDetector(
                    onTap: () {
                      if (label.toLowerCase().contains("phone")) {
                        controller.removePhoneField(index);
                      } else {
                        controller.removeSocialMediaField(index);
                      }
                    },
                    child: Icon(
                      Icons.remove_circle_rounded,
                      color: Get.theme.colorScheme.primary,
                    ),
                  ),
                if (index == controllers.length - 1)
                  GestureDetector(
                    onTap: () {
                      if (label.toLowerCase().contains("phone")) {
                        controller.addPhoneField();
                      } else {
                        controller.addSocialMediaLinkField();
                      }
                    },
                    child: Icon(
                      Icons.add_circle_rounded,
                      color: Get.theme.colorScheme.primary,
                    ),
                  )
              ],
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: Get.height * 0.02),
    );
  }
}
