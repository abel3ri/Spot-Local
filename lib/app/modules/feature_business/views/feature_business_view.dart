import 'package:business_dir/app/modules/my_businesses/controllers/my_businesses_controller.dart';
import 'package:business_dir/app/widgets/r_card.dart';
import 'package:business_dir/app/widgets/r_gradient_button.dart';
import 'package:business_dir/app/widgets/r_loading.dart';
import 'package:business_dir/app/widgets/r_text_icon_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/feature_business_controller.dart';

class FeatureBusinessView extends GetView<FeatureBusinessController> {
  const FeatureBusinessView({super.key});

  @override
  Widget build(BuildContext context) {
    final business =
        Get.find<MyBusinessesController>().toBeFeaturedBusiness.value;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          "Feature - ${business!.name}",
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  content: const Text(
                    "Please note that chapa in app payment may not work on older devices",
                  ),
                ),
              );
            },
            icon: const Icon(Icons.info_rounded),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return const Center(
            child: RLoading(),
          );
        }
        if (controller.paymentRate.value == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Unable to load payment data."),
                RTextIconButton(
                  label: "Refresh",
                  onPressed: () async {
                    await controller.getPaymentRate();
                  },
                  icon: Icons.refresh,
                ),
              ],
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: controller.paymentRate.value!.keys.length,
                itemBuilder: (context, index) {
                  final numOfDays =
                      controller.paymentRate.value!.keys.toList()[index];
                  final amount =
                      controller.paymentRate.value!.values.toList()[index];
                  return RCard(
                    child: Obx(
                      () => RadioListTile<int>(
                        groupValue: controller.selectedNumOfDays.value,
                        title: Text.rich(
                          style: context.textTheme.bodyLarge,
                          TextSpan(
                            text: "ETB ",
                            children: [
                              TextSpan(
                                text: "$amount ",
                                style: context.textTheme.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                    text: "for ",
                                    style:
                                        context.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.normal,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "$numOfDays ",
                                        style: context.textTheme.bodyLarge!
                                            .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "days",
                                            style: context.textTheme.bodyLarge!
                                                .copyWith(
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        value: int.parse(numOfDays),
                        onChanged: (value) {
                          if (value != null) {
                            controller.selectedNumOfDays.value = value;
                          }
                        },
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    SizedBox(height: Get.height * 0.02),
              ),
              SizedBox(height: Get.height * 0.02),
              Obx(
                () => RGradientButton(
                  label: "Proceed",
                  onPressed: controller.selectedNumOfDays.value == 0
                      ? null
                      : () async {
                          await controller.pay();
                        },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
