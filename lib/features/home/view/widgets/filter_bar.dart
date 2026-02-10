import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controller/home_controller.dart';
import '../../../market/widgets/category_chip.dart';

class FilterBar extends StatelessWidget {
  final HomeFilter selectedFilter;
  final ValueChanged<HomeFilter> onChanged;

  const FilterBar({
    super.key,
    required this.selectedFilter,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final filters = const [
      HomeFilter.product,
      HomeFilter.designer,
      HomeFilter.contractor,
      HomeFilter.all,
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < filters.length; i++) ...[
            CategoryChip(
              label: filters[i].labelAr,
              isActive: selectedFilter == filters[i],
              onTap: () => onChanged(filters[i]),
            ),
            if (i != filters.length - 1) SizedBox(width: 10.w),
          ],
        ],
      ),
    );
  }
}
