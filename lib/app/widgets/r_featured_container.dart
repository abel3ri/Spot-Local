import 'package:business_dir/app/data/models/featured_model.dart';
import 'package:business_dir/app/modules/manage_requests/views/widgets/r_status_container.dart';
import 'package:business_dir/app/widgets/r_card.dart';
import 'package:business_dir/app/widgets/r_header_text.dart';
import 'package:business_dir/app/widgets/r_text_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RFeaturedContainer extends StatelessWidget {
  const RFeaturedContainer({
    super.key,
    required this.featured,
    required this.userRole,
    this.onApproveBtnTap,
    this.onMarkExpireBtnTap,
  });

  final FeaturedModel featured;
  final String userRole;
  final void Function()? onApproveBtnTap;
  final void Function()? onMarkExpireBtnTap;

  @override
  Widget build(BuildContext context) {
    return RCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: RHeaderText(headerText: '${featured.business?.name}'),
              ),
              RStatusContainer(status: featured.status!),
            ],
          ),
          SizedBox(height: Get.height * 0.02),
          Text(
            'ETB ${featured.paymentAmount?.toStringAsFixed(2)}',
            style: context.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Get.height * 0.01),
          Text(
            'Submitted on - ${DateFormat.yMMMEd("en-US").format(
              featured.createdAt!,
            )}',
            style: context.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Get.height * 0.01),
          if (featured.status == "expired")
            Text(
              "Expired - ${DateFormat.yMMMEd("en-US").format(
                featured.expiresOn!,
              )}",
              style: context.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            )
          else
            Text(
              'Will Expire On - ${DateFormat.yMMMEd("en-US").format(
                featured.expiresOn!,
              )}',
              style: context.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          SizedBox(height: Get.height * 0.02),
          if (featured.status == 'pending' && userRole == 'admin')
            Center(
              child: RTextIconButton(
                label: "Approve",
                icon: Icons.check_rounded,
                color: Colors.green,
                onPressed: onApproveBtnTap,
              ),
            ),
          if (featured.status == 'active' && userRole == 'admin')
            Center(
              child: RTextIconButton(
                label: "Mark expired",
                icon: Icons.block_rounded,
                color: Colors.red,
                onPressed: onMarkExpireBtnTap,
              ),
            ),
        ],
      ),
    );
  }
}
