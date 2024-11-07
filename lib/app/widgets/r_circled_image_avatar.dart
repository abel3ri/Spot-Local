import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RCircledImageAvatar extends StatelessWidget {
  const RCircledImageAvatar.medium({
    super.key,
    this.imageUrl,
    required this.fallBackText,
  })  : radius = 36,
        boxSize = 64;

  const RCircledImageAvatar.small({
    super.key,
    this.imageUrl,
    required this.fallBackText,
  })  : radius = 16,
        boxSize = 26;

  const RCircledImageAvatar({
    super.key,
    this.imageUrl,
    required this.fallBackText,
  })  : radius = 48,
        boxSize = 84;

  final String? imageUrl;
  final String fallBackText;
  final double radius;
  final double boxSize;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: SizedBox(
          width: boxSize,
          height: boxSize,
          child: imageUrl != null
              ? FadeInImage.assetNetwork(
                  placeholder: "assets/image.png",
                  image: imageUrl!,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Transform.scale(
                      scale: .8,
                      child: Image.asset(
                        "assets/image.png",
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                )
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  color: Get.theme.primaryColor,
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        fallBackText.toUpperCase(),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
