import 'package:business_dir/app/widgets/r_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RModalBottomSheet extends StatelessWidget {
  const RModalBottomSheet({
    super.key,
    required this.label,
    required this.children,
  });

  final String label;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(),
        ),
        ...children,
        RListTile(
          title: "Cancel",
          leadingIcon: Icons.close,
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }
}
