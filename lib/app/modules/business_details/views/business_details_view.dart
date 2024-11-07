import 'package:business_dir/app/controllers/auth_controller.dart';
import 'package:business_dir/app/controllers/location_controller.dart';
import 'package:business_dir/app/modules/business_details/views/widgets/business_profile_card.dart';
import 'package:business_dir/app/modules/business_details/views/widgets/r_info_container.dart';
import 'package:business_dir/app/modules/business_details/views/widgets/r_rating_row.dart';
import 'package:business_dir/app/modules/home/controllers/home_controller.dart';
import 'package:business_dir/app/widgets/r_card.dart';
import 'package:business_dir/app/widgets/r_chip.dart';
import 'package:business_dir/app/widgets/r_circled_image_avatar.dart';
import 'package:business_dir/app/widgets/r_header_text.dart';
import 'package:business_dir/app/widgets/r_linear_indicator.dart';
import 'package:business_dir/app/widgets/shimmers/performance_card_shimmer.dart';
import 'package:business_dir/app/widgets/shimmers/r_circled_button.dart';
import 'package:business_dir/app/widgets/shimmers/rating_shimmer_grid.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/business_details_controller.dart';

class BusinessDetailsView extends GetView<BusinessDetailsController> {
  const BusinessDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    final business = Get.find<HomeController>().business.value!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          business.name!,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () async {
                final locationController = Get.find<LocationController>();
                locationController.isLoading.value = true;
                await locationController.getUserCurrentPosition();
                locationController.setBusinessInfo(
                  coords: business.latLng!,
                  name: business.name!,
                );
              },
              icon: Icon(
                Icons.explore_rounded,
                color: context.theme.colorScheme.primary,
                size: 28,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Obx(
            () => Get.find<LocationController>().isLoading.isTrue
                ? const RLinearIndicator()
                : const SizedBox(),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
              top: 8,
              left: 16,
              right: 16,
              bottom: Get.height * 0.1,
            ),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                BusinessProfileCard(
                  logoUrl: business.logo != null ? business.logo!['url'] : null,
                  name: business.name!,
                  description: business.description ?? "",
                  isVerified: business.isVerified!,
                ),
                SizedBox(height: Get.height * 0.02),
                const Divider(thickness: .1),
                RHeaderText(headerText: "categories".tr),
                const Divider(thickness: .1),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 4,
                    children: business.categories!
                        .map(
                          (category) => RChip(
                            label: category.name,
                            onTap: () {
                              Get.toNamed(
                                "category",
                                arguments: {
                                  "id": category.id,
                                  "name": category.name,
                                  "description": category.description,
                                },
                              );
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
                const Divider(thickness: .1),
                RHeaderText(headerText: "performance".tr),
                const Divider(thickness: .1),
                SizedBox(height: Get.height * 0.02),
                Obx(() {
                  if (controller.isLoading.isTrue) {
                    return const PerformanceShimmer();
                  }
                  final averageRating = controller
                          .businessPerformance.value?.averageRating
                          .toDouble() ??
                      0.0;
                  final totalReviews =
                      controller.businessPerformance.value?.totalReviews ?? 0;
                  return SizedBox(
                    width: Get.width,
                    child: RCard(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            averageRating.toStringAsFixed(1),
                            style: GoogleFonts.stardosStencil(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          RatingBarIndicator(
                            itemSize: 32,
                            rating: averageRating,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => Icon(
                              Icons.star_rounded,
                              color: context.theme.colorScheme.primary,
                            ),
                          ),
                          SizedBox(height: Get.height * 0.01),
                          Text(
                            '$totalReviews ${'review'.tr}',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                if (business.images?.isNotEmpty ?? false) ...[
                  SizedBox(height: Get.height * 0.02),
                  const Divider(thickness: .1),
                  RHeaderText(headerText: "gallery".tr),
                  const Divider(thickness: .1),
                  SizedBox(height: Get.height * 0.02),
                  CarouselSlider.builder(
                    itemCount: business.images!.length,
                    itemBuilder: (context, index, page) {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: FadeInImage.assetNetwork(
                              fadeInDuration: const Duration(milliseconds: 300),
                              fadeOutDuration:
                                  const Duration(milliseconds: 300),
                              fit: BoxFit.fitWidth,
                              placeholder: "assets/image.png",
                              image: business.images?[index]?['url'] ?? "",
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  "assets/image.png",
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                          Positioned(
                            top: 4,
                            left: 4,
                            child: RCircledButton(
                              icon: Icons.fullscreen_rounded,
                              onTap: () {
                                Get.toNamed("/image-preview", arguments: {
                                  "imagePath": business.images![index]!['url'],
                                });
                              },
                            ),
                          ),
                        ],
                      );
                    },
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                    ),
                  ),
                ],
                SizedBox(height: Get.height * 0.02),
                const Divider(thickness: .1),
                RHeaderText(headerText: "contactInfo".tr),
                const Divider(thickness: .1),
                if (business.phone?.isNotEmpty ?? false)
                  RContactInfoRow(
                    icon: Icons.phone,
                    child: Column(
                      children: business.phone!
                          .map(
                            (phone) => GestureDetector(
                              onTap: () async {
                                await launchUrl(Uri.parse("tel:$phone"));
                              },
                              child: Text(
                                phone,
                                style: context.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                if (business.email != null) ...[
                  SizedBox(height: Get.height * 0.01),
                  RContactInfoRow(
                    icon: Icons.email,
                    child: GestureDetector(
                      onTap: () async {
                        await launchUrl(Uri.parse("mailto:${business.email}"));
                      },
                      child: Text(
                        business.email!,
                        style: context.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
                if (business.phone == null &&
                    business.email == null &&
                    business.website == null) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Business has no contact info",
                      style: context.textTheme.bodyLarge,
                    ),
                  ),
                ],
                SizedBox(height: Get.height * 0.01),
                if (business.website != null)
                  RContactInfoRow(
                    icon: Icons.public_rounded,
                    child: GestureDetector(
                      onTap: () async {
                        await launchUrl(Uri.parse(business.website!));
                      },
                      child: Text(
                        business.website!,
                        style: context.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                if (business.socialMedia?.isNotEmpty ?? false) ...[
                  SizedBox(height: Get.height * 0.02),
                  const Divider(thickness: .1),
                  RHeaderText(headerText: "socialMedia".tr),
                  const Divider(thickness: .1),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: 8,
                      children: List.generate(
                        business.socialMedia!.length,
                        (index) {
                          return GestureDetector(
                            onTap: () async {
                              await launchUrl(
                                Uri.parse(
                                  business.socialMedia![index],
                                ),
                              );
                            },
                            child: RCircledImageAvatar.small(
                              fallBackText: "Social",
                              imageUrl:
                                  'https://logo.clearbit.com/${Uri.parse(business.socialMedia![index]).host}',
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
                SizedBox(height: Get.height * 0.02),
                const Divider(thickness: .1),
                RHeaderText(headerText: "businessLocation".tr),
                const Divider(thickness: .1),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    children: [
                      Text(
                        '${business.address}, ${business.city?.name}',
                        style: context.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                if (business.operationHours?.isNotEmpty ?? false) ...[
                  SizedBox(height: Get.height * 0.02),
                  const Divider(thickness: .1),
                  RHeaderText(headerText: "operationHours".tr),
                  const Divider(thickness: .1),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${business.operationHours}',
                      style: context.textTheme.bodyLarge,
                    ),
                  ),
                ],
                SizedBox(height: Get.height * 0.02),
                const Divider(thickness: .1),
                RHeaderText(headerText: "userReviews".tr),
                const Divider(thickness: .1),
                Obx(
                  () {
                    if (controller.isLoading.isTrue) {
                      return const RatingShimmerGrid();
                    }
                    if (controller.reviews.value.isEmpty) {
                      return Text(
                        "noReviewsYet".tr,
                        style: context.textTheme.titleMedium,
                      );
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: controller.reviews.value.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final review = controller.reviews.value[index];
                        return RCard(
                          child: RRatingRow(
                            review: review,
                            businessOwnerId: business.owner?.id,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: Get.height * 0.02,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomAppBar(
              color: context.theme.cardColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: FilledButton(
                  onPressed: () {
                    if (Get.find<AuthController>().currentUser.value != null) {
                      Get.toNamed("review");
                    } else {
                      Get.toNamed("login", arguments: {
                        "previousRoute": Get.currentRoute,
                      });
                    }
                  },
                  child: Text(
                    Get.find<AuthController>().currentUser.value != null
                        ? "writeReview".tr
                        : "loginOrSignUpToMakeReview".tr,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
