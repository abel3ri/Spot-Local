import 'package:business_dir/app/widgets/shimmers/chip_shimmer.dart';
import 'package:flutter/material.dart';

class ChipWrapShimmer extends StatelessWidget {
  const ChipWrapShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 2,
      children: List.generate(12, (index) => const ChipShimmer()),
    );
  }
}
