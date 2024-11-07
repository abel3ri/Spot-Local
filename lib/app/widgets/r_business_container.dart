import 'package:business_dir/app/controllers/location_controller.dart';
import 'package:business_dir/app/data/models/business_model.dart';
import 'package:business_dir/app/modules/favorite/controllers/favorite_controller.dart';

import 'package:business_dir/app/modules/home/controllers/home_controller.dart';

import 'package:business_dir/app/widgets/r_card.dart';
import 'package:business_dir/app/widgets/r_circled_image_avatar.dart';
import 'package:business_dir/app/widgets/r_text_icon_button.dart';
import 'package:business_dir/utils/social_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RBusinessContainer extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  final favoriteController = Get.find<FavoriteController>();
  RBusinessContainer({
    super.key,
    required this.business,
  });

  final BusinessModel business;

  @override
  Widget build(BuildContext context) {
    List<String> socialMedias = [
      "facebook",
      "telegram",
      "whatsapp",
      "linkedin",
      "twitter",
      "instagram",
    ];

    return GestureDetector(
      onTap: () {
        homeController.business.value = business;
        Get.toNamed("/business-details");
      },
      child: RCard(
        child: Stack(
          children: [
            Column(
              children: [
                RCircledImageAvatar.medium(
                  fallBackText: "logo",
                  imageUrl: business.logo?['url'],
                ),
                SizedBox(height: Get.height * 0.01),
                Text(
                  business.name!,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                Text(
                  '${business.description}',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(thickness: .2),
                Wrap(
                  children: business.categories!
                      .map(
                        (category) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Text(
                            category.name.toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 8,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const Divider(thickness: .1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      business.averageRating?.toStringAsFixed(1) ??
                          "No ratings",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.star_rounded,
                      size: 16,
                      color: context.theme.colorScheme.primary,
                    ),
                  ],
                ),
                const Divider(thickness: .1),
                Text(
                  business.address!,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: RTextIconButton.small(
                    label: "showDirection".tr,
                    onPressed: () async {
                      final locationController = Get.find<LocationController>();
                      locationController.isLoading.value = true;
                      await locationController.getUserCurrentPosition();
                      locationController.setBusinessInfo(
                        coords: business.latLng!,
                        name: business.name!,
                      );
                    },
                    icon: Icons.directions,
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        business.isFavorited.value =
                            !business.isFavorited.value;
                        if (business.isFavorited.isFalse) {
                          await favoriteController.deleteFavorite(
                            businessId: business.id!,
                          );
                        } else {
                          await favoriteController.create(
                            businessId: business.id!,
                          );
                        }
                      },
                      child: Obx(
                        () => Icon(
                          business.isFavorited.isTrue
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: business.isFavorited.isTrue
                              ? context.theme.colorScheme.primary
                              : context.theme.colorScheme.secondary,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    GestureDetector(
                      onTap: () async {
                        showModalBottomSheet(
                          backgroundColor:
                              context.theme.scaffoldBackgroundColor,
                          context: context,
                          builder: (context) => Column(
                            children: [
                              Text(
                                "shareToAFriend".tr,
                                style: context.textTheme.titleLarge,
                              ),
                              SizedBox(height: Get.height * 0.02),
                              Expanded(
                                child: ListView.separated(
                                  itemCount: socialMedias.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (business.website != null) {
                                          SocialShare.shareBusiness(
                                            socialMedia: socialMedias[index],
                                            url: business.website!,
                                          );
                                        } else {
                                          SocialShare.shareBusiness(
                                            socialMedia: socialMedias[index],
                                            url:
                                                "Hey! check out ${business.name!} on eTech's Business Directory Mobile App.",
                                          );
                                        }

                                        Get.back();
                                      },
                                      child: SvgPicture.asset(
                                        "assets/social_media/${socialMedias[index]}-logo-fill.svg",
                                        width: 48,
                                        height: 48,
                                        colorFilter: ColorFilter.mode(
                                          Get.isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          constraints: BoxConstraints(
                            maxHeight: Get.height * 0.22,
                            minWidth: Get.width,
                          ),
                          showDragHandle: true,
                        );
                      },
                      child: Icon(
                        Icons.share_rounded,
                        color: context.theme.colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (business.isVerified!)
              Positioned(
                top: 0,
                left: 0,
                child: Icon(Icons.verified, color: context.theme.primaryColor),
              ),
          ],
        ),
      ),
    );
  }
}
