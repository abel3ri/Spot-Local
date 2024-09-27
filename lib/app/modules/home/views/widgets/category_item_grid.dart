import 'package:business_dir/app/modules/home/views/widgets/category_item.dart';
import 'package:business_dir/utils/utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CategoryItemsGrid extends StatelessWidget {
  // final categoryContoller = Get.find<CategoryController>();
  CategoryItemsGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: MasonryGridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 8,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemBuilder: (context, index) {
          // final category = categoryContoller.categories.value[index];
          return CategoryItem(
            onTap: () {},
            name: "Name",
            icon: Icons.business,
            color: getCategoryItemColor(index),
          );
        },
      ),
    );
  }
}
