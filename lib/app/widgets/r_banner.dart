import 'package:business_dir/app/widgets/r_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RBanner extends StatelessWidget {
  const RBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        RBannerCard(
          content: "elevateYourBrand".tr,
        ),
        RBannerCard(
          content: "letUsHelp".tr,
        ),
        RBannerCard(
          content: "findItFast".tr,
        ),
      ],
      options: CarouselOptions(
        aspectRatio: 2 / 1,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
    );
  }
}

class RBannerCard extends StatelessWidget {
  const RBannerCard({
    super.key,
    required this.content,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return RCard(
      gradient: true,
      color: Get.theme.primaryColor,
      child: Center(
        child: Text(
          content,
          style: context.textTheme.titleLarge!.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
