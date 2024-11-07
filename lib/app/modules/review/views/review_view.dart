import 'package:business_dir/app/modules/home/controllers/home_controller.dart';
import 'package:business_dir/app/widgets/r_button.dart';
import 'package:business_dir/app/widgets/r_card.dart';
import 'package:business_dir/app/widgets/r_circular_indicator.dart';
import 'package:business_dir/app/widgets/r_input_field_row.dart';
import 'package:business_dir/utils/form_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';

import '../controllers/review_controller.dart';

class ReviewView extends GetView<ReviewController> {
  const ReviewView({super.key});
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
          "writeAReview".tr,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          RCard(
            child: Column(
              children: [
                Text(
                  "rateYourExperience".tr,
                  style: context.textTheme.titleLarge,
                ),
                SizedBox(height: Get.height * 0.01),
                RatingBar.builder(
                  allowHalfRating: true,
                  glow: false,
                  maxRating: 5,
                  minRating: 1,
                  itemBuilder: (context, index) {
                    return Icon(
                      Icons.star_rounded,
                      color: context.theme.primaryColor,
                    );
                  },
                  onRatingUpdate: controller.onRatingChanged,
                ),
                SizedBox(height: Get.height * 0.01),
                Obx(
                  () => controller.rating.value != null
                      ? Text(
                          "(${controller.rating.value.toString()})",
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          ),
          Obx(
            () => controller.rating.value != null
                ? Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: Get.height * 0.02),
                        RInputField(
                          controller: controller.ratingController,
                          label: "reviewLabel".tr,
                          hintText: "writeYourExperience".tr,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          maxLines: 5,
                          validator: FormValidator.reviewValidator,
                        ),
                        SizedBox(height: Get.height * 0.02),
                        RButton(
                          child: Obx(
                            () => controller.isLoading.isTrue
                                ? const RCircularIndicator()
                                : Text("submit".tr),
                          ),
                          onPressed: () async {
                            if (controller.formKey.currentState!.validate()) {
                              if (Get.focusScope?.hasFocus ?? false) {
                                Get.focusScope!.unfocus();
                              }
                              final Map<String, dynamic> ratingData = {
                                "rating": controller.rating.value,
                                "comment": controller.ratingController.text,
                                "businessId": Get.find<HomeController>()
                                    .business
                                    .value!
                                    .id,
                              };
                              await controller.createRating(
                                ratingData: ratingData,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
