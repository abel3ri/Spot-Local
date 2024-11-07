import 'package:business_dir/app/widgets/r_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessProfileCard extends StatelessWidget {
  final String? logoUrl;
  final String name;
  final bool isVerified;
  final String description;

  const BusinessProfileCard({
    super.key,
    this.logoUrl,
    required this.name,
    required this.description,
    required this.isVerified,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (logoUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/image.png",
                    image: logoUrl!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "assets/image.png",
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                )
              else
                Center(
                  child: CircleAvatar(
                    child: Text(
                      name[0],
                      style: context.textTheme.titleLarge,
                    ),
                  ),
                ),
              SizedBox(width: Get.width * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: context.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: context.textTheme.bodyLarge,
                      maxLines: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (isVerified)
          Positioned(
            top: 0,
            right: 0,
            child: Icon(
              Icons.verified_rounded,
              color: context.theme.colorScheme.primary,
              size: 32,
            ),
          ),
      ],
    );
  }
}
