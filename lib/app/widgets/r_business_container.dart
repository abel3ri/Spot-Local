import 'package:business_dir/app/data/models/business_model.dart';
import 'package:business_dir/app/widgets/r_card.dart';
import 'package:business_dir/utils/social_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RBusinessContainer extends StatelessWidget {
  const RBusinessContainer({
    super.key,
    required this.business,
    required this.onShowDirectionTap,
    required this.tag,
  });

  final BusinessModel business;
  final Function() onShowDirectionTap;
  final String tag;

  @override
  Widget build(BuildContext context) {
    print(business.logo);
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
        Get.toNamed(
          "business-details",
          arguments: {
            "business": business,
            "tag": tag,
          },
        );
      },
      child: RCard(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 64,
                  width: 64,
                  child: Hero(
                    tag: tag,
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/image.png",
                      image: business.logo!,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/image.png",
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                Text(
                  business.name!,
                  overflow: TextOverflow.ellipsis,
                  style: Get.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: Get.height * 0.01),
                Text(
                  '${business.description}',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Get.textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(thickness: .2),
                Wrap(
                  children: business.categories!
                      .map((category) => Chip(
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.transparent,
                            padding: const EdgeInsets.all(0),
                            side: BorderSide.none,
                            label: Text(
                              category.name.toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              style: Get.textTheme.bodySmall!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 8,
                              ),
                            ),
                          ))
                      .toList(),
                ),
                const Divider(thickness: .1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${business.averageRating ?? "No ratings"}",
                      style: Get.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.star_rounded,
                      size: 16,
                      color: Get.theme.colorScheme.primary,
                    ),
                  ],
                ),
                const Divider(thickness: .1),
                Text(
                  business.address!,
                  overflow: TextOverflow.ellipsis,
                  style: Get.textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                // Spacer(),
                TextButton.icon(
                  label: Text(
                    "showDirection".tr,
                    style: Get.textTheme.bodySmall,
                  ),
                  onPressed: onShowDirectionTap,
                  iconAlignment: IconAlignment.end,
                  icon: const Icon(Icons.directions),
                )
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
                      onTap: () {},
                      child: Icon(
                        Icons.favorite_border_rounded,
                        color: Get.theme.colorScheme.secondary,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    GestureDetector(
                      onTap: () async {
                        showModalBottomSheet(
                          backgroundColor: Get.theme.scaffoldBackgroundColor,
                          context: context,
                          builder: (context) => Column(
                            children: [
                              Text(
                                "Share to a friend!",
                                style: Get.textTheme.titleLarge,
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
                                                "Hey! Check out ${business.name!} on BUsiness Directory app.",
                                          );
                                        }

                                        Get.back();
                                      },
                                      child: SvgPicture.asset(
                                        "assets/social_media/${socialMedias[index]}-logo-fill.svg",
                                        width: 48,
                                        height: 48,
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
                            maxHeight: Get.height * 0.2,
                            minWidth: Get.width,
                          ),
                          showDragHandle: true,
                        );
                      },
                      child: Icon(
                        Icons.share_rounded,
                        color: Get.theme.colorScheme.secondary,
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
                child: Icon(Icons.verified, color: Get.theme.primaryColor),
              ),
          ],
        ),
      ),
    );
  }
}
