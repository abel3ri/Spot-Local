import 'package:business_dir/app/modules/business_details/controllers/business_details_controller.dart';
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

class EditReviewView extends GetView<ReviewController> {
  const EditReviewView({super.key});
  @override
  Widget build(BuildContext context) {
    final currentReview = Get.find<BusinessDetailsController>().review.value;
    controller.ratingController.text =
        currentReview!.comment ?? "Write your experience";
    controller.rating.value = currentReview.rating.toDouble();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          "Edit your review",
          style: Get.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(16),
        children: [
          RCard(
            child: Column(
              children: [
                Text(
                  "Rate your experience",
                  style: Get.textTheme.titleLarge,
                ),
                SizedBox(height: Get.height * 0.01),
                RatingBar.builder(
                  allowHalfRating: true,
                  glow: false,
                  maxRating: 5,
                  initialRating: currentReview.rating.toDouble(),
                  minRating: 1,
                  itemBuilder: (context, index) {
                    return Icon(
                      Icons.star_rounded,
                      color: Get.theme.primaryColor,
                    );
                  },
                  onRatingUpdate: controller.onRatingChanged,
                ),
                SizedBox(height: Get.height * 0.01),
                Obx(() {
                  return Text(
                    "(${controller.rating.value.toString()})",
                    style: Get.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }),
              ],
            ),
          ),
          Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: Get.height * 0.02),
                RInputField(
                  controller: controller.ratingController,
                  label: "Review",
                  hintText: "Write your exprience",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  maxLines: 5,
                  validator: FormValidator.reviewValidator,
                ),
                SizedBox(height: Get.height * 0.02),
                RButton(
                  child: Obx(
                    () => controller.isLoading.isTrue
                        ? RCircularIndicator()
                        : Text("Submit"),
                  ),
                  onPressed: () async {
                    if (controller.formKey.currentState!.validate()) {
                      if (Get.focusScope?.hasFocus ?? false) {
                        Get.focusScope!.unfocus();
                      }
                      final Map<String, dynamic> ratingData = {
                        "rating": controller.rating.value,
                        "comment": controller.ratingController.text,
                        "businessId":
                            Get.find<HomeController>().business.value!.id,
                      };
                      await controller.updateRating(
                        ratingData: ratingData,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
