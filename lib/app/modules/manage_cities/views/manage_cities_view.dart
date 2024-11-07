import 'package:business_dir/app/data/models/city_model.dart';
import 'package:business_dir/app/modules/manage_cities/views/create_city_view.dart';
import 'package:business_dir/app/modules/manage_cities/views/update_city_view.dart';
import 'package:business_dir/app/widgets/r_card.dart';
import 'package:business_dir/app/widgets/r_delete_alert.dart';
import 'package:business_dir/app/widgets/r_loading.dart';
import 'package:business_dir/app/widgets/r_not_found.dart';
import 'package:business_dir/app/widgets/r_text_icon_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../controllers/manage_cities_controller.dart';

class ManageCitiesView extends GetView<ManageCitiesController> {
  const ManageCitiesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          "manageCities".tr,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          RTextIconButton(
            label: "create".tr,
            onPressed: () {
              controller.fetchStates();
              Get.to(() => const CreateCityView());
            },
            icon: Icons.add,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => controller.pagingController.refresh(),
        ),
        child: PagedListView.separated(
          pagingController: controller.pagingController,
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          builderDelegate: PagedChildBuilderDelegate<CityModel>(
              animateTransitions: true,
              firstPageErrorIndicatorBuilder: (context) =>
                  RNotFound(label: "anErrorHasOccured".tr),
              newPageErrorIndicatorBuilder: (context) =>
                  RNotFound(label: "anErrorHasOccured".tr),
              firstPageProgressIndicatorBuilder: (context) => const RLoading(),
              newPageProgressIndicatorBuilder: (context) => const RLoading(),
              noItemsFoundIndicatorBuilder: (context) =>
                  const RNotFound(label: "No city found!"),
              itemBuilder: (context, city, index) {
                return RCard(
                    child: Row(
                  children: [
                    Text(
                      "${city.name}",
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        controller.fetchStates();
                        controller.setSelectedCity(city);
                        Get.to(() => const UpdateCityView());
                      },
                      icon: Icon(
                        Icons.edit,
                        color: context.theme.primaryColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) => RDeleteAlert(
                            onPressed: () async {
                              Get.back();
                              await controller.deleteCity(cityId: city.id!);
                            },
                            itemType: "City",
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ));
              }),
          separatorBuilder: (context, index) => SizedBox(
            height: Get.height * 0.02,
          ),
        ),
      ),
    );
  }
}
