import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CategoryItem extends StatelessWidget {
  final String name;
  final String? icon;
  final Color? color;
  Function()? onTap;
  CategoryItem({
    super.key,
    required this.onTap,
    required this.name,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          CircleAvatar(
            backgroundColor: color ?? context.theme.colorScheme.primary,
            child: icon != null
                ? SvgPicture.string(
                    icon!,
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                  )
                : SvgPicture.asset(
                    "assets/misc/more.svg",
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                  ),
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: context.textTheme.bodySmall!,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
