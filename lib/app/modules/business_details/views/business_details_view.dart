import 'package:business_dir/app/controllers/auth_controller.dart';
import 'package:business_dir/app/controllers/location_controller.dart';
import 'package:business_dir/app/data/models/review_model.dart';
import 'package:business_dir/app/modules/business_details/widgets/business_profile_card.dart';
import 'package:business_dir/app/modules/home/controllers/home_controller.dart';
import 'package:business_dir/app/widgets/r_card.dart';
import 'package:business_dir/app/widgets/r_header_text.dart';
import 'package:business_dir/app/widgets/r_linear_indicator.dart';
import 'package:business_dir/app/widgets/shimmers/performance_card_shimmer.dart';
import 'package:business_dir/app/widgets/shimmers/rating_shimmer_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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
          style: Get.textTheme.bodyMedium!.copyWith(
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
          preferredSize: Size.fromHeight(4),
          child: Obx(
            () => Get.find<LocationController>().isLoading.isTrue
                ? RLinearIndicator()
                : SizedBox(),
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
                  tag: "tag",
                  logoUrl: business.logo,
                  name: business.name!,
                  description: business.description ?? "",
                  isVerified: business.isVerified!,
                ),
                const RHeaderText(headerText: "Categories"),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 4,
                    children: business.categories!
                        .map((category) => Chip(
                              padding: EdgeInsets.symmetric(horizontal: 0),
                              shape: StadiumBorder(
                                side: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              backgroundColor: context.theme.primaryColor,
                              labelStyle: Get.textTheme.bodyMedium!.copyWith(
                                color: Colors.white,
                              ),
                              label: Text(category.name),
                            ))
                        .toList(),
                  ),
                ),
                const RHeaderText(headerText: "Performance"),
                Obx(() {
                  if (controller.isLoading.isTrue) {
                    return PerformanceShimmer();
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
                            "${averageRating.toStringAsFixed(1)}",
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
                            '${totalReviews} Review(s)',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                if (business.images!.isNotEmpty) ...[
                  const RHeaderText(headerText: "Gallery"),
                  SizedBox(
                    height: Get.height * 0.3,
                    child: Container(
                      child: ScrollConfiguration(
                        behavior: ScrollBehavior().copyWith(
                          overscroll: false,
                        ),
                        child: CarouselView(
                          itemExtent: Get.width * 0.85,
                          itemSnapping: true,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          children: List.generate(
                            business.images?.length ?? 0,
                            (index) => FadeInImage.assetNetwork(
                              fadeInDuration: Duration(milliseconds: 300),
                              fadeOutDuration: Duration(milliseconds: 300),
                              fit: BoxFit.cover,
                              placeholder: "assets/image.png",
                              image: business.images?[index] ?? "",
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  "assets/image.png",
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                const RHeaderText(headerText: "Contact Information"),
                if (business.phone != null)
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
                                style: Get.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                SizedBox(height: Get.height * 0.01),
                if (business.email != null)
                  RContactInfoRow(
                    icon: Icons.email,
                    child: GestureDetector(
                      onTap: () async {
                        await launchUrl(Uri.parse("mailto:${business.email}"));
                      },
                      child: Text(
                        business.email!,
                        style: Get.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                const RHeaderText(headerText: "User ratings"),
                Obx(
                  () {
                    if (controller.isLoading.isTrue) {
                      return RatingShimmerGrid();
                    }
                    if (controller.reviews.value.isEmpty) {
                      return Text(
                        "No reviews yet. Be the first!",
                        style: Get.textTheme.titleMedium,
                      );
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: controller.reviews.value.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final rating = controller.reviews.value[index];

                        return RCard(
                          child: RRatingRow(
                            review: rating,
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
                      Get.toNamed("login");
                    }
                  },
                  child: Text(
                    Get.find<AuthController>().currentUser.value != null
                        ? "Write a Review"
                        : "Login or Sign up to make review",
                    style: Get.textTheme.bodyMedium!.copyWith(
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

class RContactInfoRow extends StatelessWidget {
  const RContactInfoRow({
    super.key,
    required this.child,
    required this.icon,
  });

  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 32),
        SizedBox(width: Get.width * 0.03),
        child,
      ],
    );
  }
}

class RRatingRow extends StatelessWidget {
  const RRatingRow({
    super.key,
    required this.review,
  });

  final ReviewModel review;

  @override
  Widget build(BuildContext context) {
    final String userFullName =
        "${review.ratedBy.firstName} ${review.ratedBy.lastName}";
    final double ratingValue = review.rating.toDouble();
    final int helpful = review.helpful;
    final DateTime createdAt = review.createdAt;
    final DateTime updatedAt = review.updatedAt;
    final String? comment = review.comment;
    final bool isOwner =
        Get.find<AuthController>().currentUser.value?.id == review.ratedBy.id;
    final Map<String, dynamic> userProfileImage = review.ratedBy.profileImage ??
        {
          "url":
              "https://eu.ui-avatars.com/api/?name=${review.ratedBy.firstName}+${review.ratedBy.lastName}&size=250",
          "publicId": null,
        };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              foregroundImage: NetworkImage(userProfileImage['url']),
              backgroundColor: Colors.transparent,
            ),
            SizedBox(width: Get.width * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userFullName,
                  overflow: TextOverflow.ellipsis,
                  style: Get.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateFormat.yMMMd("en-us").format(createdAt),
                ),
              ],
            ),
            const Spacer(),
            RatingBarIndicator(
              itemSize: 20,
              rating: ratingValue,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: context.theme.colorScheme.primary,
              ),
            ),
          ],
        ),
        if (comment != null) ...[
          SizedBox(height: Get.height * 0.02),
          Text(
            comment,
            style: Get.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
        Row(
          mainAxisAlignment:
              isOwner ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
          children: [
            if (isOwner) ...[
              Row(
                children: [
                  RTextIconButton(
                    label: "Edit",
                    icon: Icons.edit,
                    onPressed: () {
                      Get.find<BusinessDetailsController>().review.value =
                          review;
                      Get.toNamed("/edit-review");
                    },
                  ),
                  RTextIconButton(
                    label: "Delete",
                    icon: Icons.delete,
                    onPressed: () async {
                      await Get.find<BusinessDetailsController>()
                          .deleteReview(reviewId: review.id);
                    },
                  ),
                ],
              ),
            ],
            Align(
              alignment: Alignment.centerRight,
              child: RTextIconButton(
                label: "Helpful ${helpful}",
                icon: Icons.thumb_up_off_alt_rounded,
                onPressed: () {},
              ),
            ),
          ],
        ),
        if (createdAt != updatedAt)
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "edited",
              style: Get.textTheme.bodyMedium!.copyWith(
                color: Colors.grey,
              ),
            ),
          ),
      ],
    );
  }
}

class RTextIconButton extends StatelessWidget {
  const RTextIconButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      label: Text(
        label,
        style: Get.textTheme.bodySmall,
      ),
      icon: Icon(
        icon,
        size: 16,
        color: label == "Edit"
            ? context.theme.colorScheme.secondary
            : label == "Delete"
                ? context.theme.colorScheme.error
                : null,
      ),
    );
  }
}
