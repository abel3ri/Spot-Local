import 'package:business_dir/app/modules/get_started/widgets/r_onboarding_page.dart';
import 'package:business_dir/app/widgets/r_text_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/get_started_controller.dart';

class GetStartedView extends GetView<GetStartedController> {
  const GetStartedView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: Get.width * 0.4,
        surfaceTintColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Obx(
                () => Center(
                  child: Container(
                    width: controller.currentIndex.value == index ? 32 : 16,
                    height: 4,
                    decoration: BoxDecoration(
                      color: controller.currentIndex.value == index
                          ? Get.theme.primaryColor
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(width: 12),
          ),
        ),
        actions: [
          RTextIconButton(
            label: "skip".tr,
            icon: Icons.arrow_right_alt_rounded,
            onPressed: () {
              Get.offNamed("home-wrapper");
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 48, 16, 24),
        child: PageView(
          controller: controller.pageController,
          onPageChanged: (value) {
            controller.currentIndex.value = value;
          },
          physics: BouncingScrollPhysics(),
          pageSnapping: true,
          children: [
            ROnBoardingPage(
              heading: "findItFast".tr,
              description: "needSomethingNearBy".tr,
              imagePath: "assets/on_boarding/find_businesses.svg",
            ),
            ROnBoardingPage(
              heading: "unlockYourNeighborhood".tr,
              description: "exploreYourCommunity".tr,
              imagePath: "assets/on_boarding/explore_local.svg",
            ),
            ROnBoardingPage(
              heading: "elevateYourLocal".tr,
              description: "goBeyondTheUsual".tr,
              imagePath: "assets/on_boarding/hidden_treasures.svg",
            ),
          ],
        ),
      ),
    );
  }
}
