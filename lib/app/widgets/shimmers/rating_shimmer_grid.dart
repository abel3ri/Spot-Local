import 'package:business_dir/app/widgets/shimmers/rating_shimmer_item.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';

class RatingShimmerGrid extends StatelessWidget {
  const RatingShimmerGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      ),
      itemBuilder: (context, index) {
        return const RRatingRowShimmer();
      },
    );
  }
}