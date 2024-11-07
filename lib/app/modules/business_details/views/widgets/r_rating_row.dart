import 'package:business_dir/app/controllers/auth_controller.dart';
import 'package:business_dir/app/data/models/review_model.dart';
import 'package:business_dir/app/modules/business_details/controllers/business_details_controller.dart';
import 'package:business_dir/app/widgets/r_text_icon_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RRatingRow extends StatelessWidget {
  const RRatingRow({
    super.key,
    required this.review,
    required this.businessOwnerId,
  });

  final ReviewModel review;
  final String? businessOwnerId;

  @override
  Widget build(BuildContext context) {
    final String userFullName =
        "${review.ratedBy.firstName} ${review.ratedBy.lastName}";
    final double ratingValue = review.rating.toDouble();
    final DateTime createdAt = review.createdAt;
    final DateTime updatedAt = review.updatedAt;
    final String? comment = review.comment;
    final bool isOwner =
        Get.find<AuthController>().currentUser.value?.id == review.ratedBy.id;
    final Map<String, dynamic>? userProfileImage = review.ratedBy.profileImage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              foregroundImage: userProfileImage != null
                  ? NetworkImage(userProfileImage['url'])
                  : null,
              // backgroundColor: Colors.transparent,
              child: Text(
                "${review.ratedBy.firstName?[0]}${review.ratedBy.lastName?[0]}",
              ),
            ),
            SizedBox(width: Get.width * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userFullName,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyLarge!.copyWith(
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
            style: context.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (isOwner) ...[
              Row(
                children: [
                  RTextIconButton.small(
                    label: "Edit",
                    icon: Icons.edit,
                    onPressed: () {
                      Get.find<BusinessDetailsController>().review.value =
                          review;
                      Get.toNamed("/edit-review");
                    },
                  ),
                  RTextIconButton.small(
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
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (review.ratedBy.id == businessOwnerId)
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Owner",
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
            if (createdAt != updatedAt)
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "edited",
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
