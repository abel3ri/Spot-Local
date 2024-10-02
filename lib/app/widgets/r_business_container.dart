import 'package:business_dir/app/data/models/business_model.dart';
import 'package:business_dir/app/widgets/r_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

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
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 4, right: 4),
              child: Column(
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
                        if (business.website != null) {
                          await Share.shareUri(Uri.parse(business.website!));
                        } else {
                          await Share.shareUri(
                            Uri.parse(
                                "https://www.google.com/search?q=${business.name}"),
                          );
                        }
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
