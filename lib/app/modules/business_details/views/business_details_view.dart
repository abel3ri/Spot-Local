import 'package:business_dir/app/data/models/business_model.dart';
import 'package:business_dir/app/modules/business_details/widgets/business_profile_card.dart';
import 'package:business_dir/app/widgets/r_card.dart';
import 'package:business_dir/app/widgets/r_header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/business_details_controller.dart';

class BusinessDetailsView extends GetView<BusinessDetailsController> {
  const BusinessDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    final business = Get.arguments['business'] as BusinessModel;
    // print(business);
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
              onPressed: () async {},
              icon: Icon(
                Icons.explore_rounded,
                color: Get.theme.colorScheme.primary,
                size: 28,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            BusinessProfileCard(
              tag: Get.arguments['tag'],
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
                          backgroundColor: Get.theme.primaryColor,
                          labelStyle: Get.textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                          ),
                          label: Text(category.name),
                        ))
                    .toList(),
              ),
            ),
            const RHeaderText(headerText: "Average Rating"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Text(
                    business.averageRating.toString(),
                    style: Get.textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: Get.width * 0.02),
                RatingBarIndicator(
                  itemSize: 32,
                  rating: business.averageRating?.toDouble() ?? 0,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Icon(
                    Icons.star_rounded,
                    color: Get.theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            if (business.images!.isNotEmpty) ...[
              const RHeaderText(headerText: "Gallery"),
              SizedBox(
                height: Get.height * 0.3,
                child: Container(
                  child: CarouselView(
                    itemExtent: Get.width * 0.85,
                    itemSnapping: true,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(8),
                    children: List.generate(
                      business.images?.length ?? 0,
                      (index) => FadeInImage.assetNetwork(
                        fadeInDuration: Duration(seconds: 3),
                        fadeOutDuration: Duration(seconds: 3),
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
            // const Divider(),
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
            business.ratings != null
                ? ListView.separated(
                    shrinkWrap: true,
                    itemCount: business.ratings!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final rating = business.ratings![index];
                      return RCard(
                        child: RRatingRow(
                          userFirstName: rating.ratedBy.firstName ?? "",
                          userLastName: rating.ratedBy.lastName ?? "",
                          rating: rating.rating.toDouble(),
                          createdAt: rating.createdAt,
                          updatedAt: rating.updatedAt,
                          comment: rating.comment,
                          helpful: rating.helpful,
                          userProfileImage: business
                                  .ratings![index].ratedBy.profileImageUrl ??
                              "https://eu.ui-avatars.com/api/?name=${rating.ratedBy.firstName}+${business.ratings![index].ratedBy.lastName}&size=250",
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: Get.height * 0.02,
                    ),
                  )
                : Center(
                    child: Text(
                      "No ratings yet.",
                      style: Get.textTheme.bodyLarge,
                    ),
                  ),
          ],
        ),
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
    required this.userFirstName,
    required this.userLastName,
    required this.createdAt,
    required this.updatedAt,
    required this.rating,
    required this.userProfileImage,
    required this.helpful,
    this.comment,
  });

  final String userFirstName;
  final String userLastName;
  final String userProfileImage;
  final double rating;
  final int helpful;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? comment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              foregroundImage: NetworkImage(userProfileImage),
              backgroundColor: Colors.transparent,
            ),
            SizedBox(width: Get.width * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$userFirstName $userLastName',
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
              rating: rating,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Get.theme.colorScheme.primary,
              ),
            ),
          ],
        ),
        if (comment != null) ...[
          SizedBox(height: Get.height * 0.02),
          Text(
            comment!,
            style: Get.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Get.height * 0.01),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (createdAt != updatedAt) const Text("edited"),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {},
                label: Text(
                  "Helpful ($helpful)",
                  style: Get.textTheme.bodySmall,
                ),
                icon: const Icon(
                  Icons.thumb_up_alt_rounded,
                  size: 16,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
