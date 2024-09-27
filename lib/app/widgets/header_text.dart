import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({
    required this.headerText,
    super.key,
  });

  final String headerText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: Get.height * 0.02),
        Row(
          children: [
            Container(
              width: 5.0,
              height: 24.0,
              color: Theme.of(context).colorScheme.primary,
              margin: const EdgeInsets.only(right: 8.0),
            ),
            Text(
              headerText,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        SizedBox(height: Get.height * 0.02),
      ],
    );
  }
}
