import 'package:business_dir/app/data/models/state_model.dart';
import 'package:business_dir/app/modules/manage_states/controllers/manage_states_controller.dart';
import 'package:business_dir/app/modules/manage_states/views/create_state_view.dart';
import 'package:business_dir/app/widgets/r_card.dart';
import 'package:business_dir/app/widgets/r_delete_alert.dart';
import 'package:business_dir/app/widgets/r_loading.dart';
import 'package:business_dir/app/widgets/r_not_found.dart';
import 'package:business_dir/app/widgets/r_text_icon_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ManageStatesView extends GetView<ManageStatesController> {
  const ManageStatesView({super.key});
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
          "manageStates".tr,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          RTextIconButton(
            label: "create".tr,
            onPressed: () {
              Get.to(() => const CreateStateView(), arguments: {
                "title": "createState".tr,
              });
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
          builderDelegate: PagedChildBuilderDelegate<StateModel>(
              animateTransitions: true,
              firstPageErrorIndicatorBuilder: (context) =>
                  RNotFound(label: "anErrorHasOccured".tr),
              newPageErrorIndicatorBuilder: (context) =>
                  RNotFound(label: "anErrorHasOccured".tr),
              firstPageProgressIndicatorBuilder: (context) => const RLoading(),
              newPageProgressIndicatorBuilder: (context) => const RLoading(),
              noItemsFoundIndicatorBuilder: (context) =>
                  RNotFound(label: "noStateFound".tr),
              itemBuilder: (context, state, index) {
                return RCard(
                    child: Row(
                  children: [
                    Text(
                      "${state.name}",
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        controller.setSelectedState(state);
                        Get.to(() => const CreateStateView(), arguments: {
                          "title": "updateState".tr,
                        });
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
                              controller.deleteState(stateId: state.id!);
                            },
                            itemType: "State",
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
