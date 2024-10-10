import 'package:business_dir/app/modules/get_started/controllers/get_started_controller.dart';
import 'package:business_dir/app/modules/get_started/views/widgets/r_next_prev_button.dart';
import 'package:business_dir/app/widgets/r_text_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ROnBoardingPage extends StatelessWidget {
  const ROnBoardingPage({
    super.key,
    required this.heading,
    required this.description,
    required this.imagePath,
  });

  final String heading;
  final String description;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GetStartedController>();
    return Column(
      children: [
        Text(
          heading,
          style: Get.textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: Get.height * 0.03),
        Text(description, textAlign: TextAlign.center),
        SizedBox(height: Get.height * 0.03),
        SizedBox(
          height: Get.height * 0.4,
          width: Get.width * 0.8,
          child: FittedBox(
            fit: BoxFit.contain,
            child: SvgPicture.asset(imagePath),
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RNextPrevButton(
                  isVisible: controller.currentIndex.value != 0,
                  onPressed: () async {
                    await controller.pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: Icons.arrow_back,
                ),
                RNextPrevButton(
                  isVisible: controller.currentIndex.value != 2,
                  onPressed: () async {
                    await controller.pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: Icons.arrow_forward,
                ),
                if (controller.currentIndex.value == 2)
                  RTextIconButton(
                    label: "Get started",
                    icon: Icons.arrow_right_alt_rounded,
                    onPressed: () {
                      Get.toNamed("/login");
                    },
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
