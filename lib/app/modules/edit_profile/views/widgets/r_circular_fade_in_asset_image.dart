import 'package:flutter/material.dart';

class RCircularFadeInAssetNetworkImage extends StatelessWidget {
  const RCircularFadeInAssetNetworkImage({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 48,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: FadeInImage.assetNetwork(
          placeholder: "assets/image.png",
          image: imagePath,
          fit: BoxFit.cover,
          imageErrorBuilder: (context, error, stackTrace) {
            return Transform.scale(
              scale: .7,
              child: Image.asset(
                "assets/image.png",
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}
