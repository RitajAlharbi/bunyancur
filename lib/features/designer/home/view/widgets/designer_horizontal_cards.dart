import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/designer_home_model.dart';
import 'designer_project_card.dart';

class DesignerHorizontalCards extends StatelessWidget {
  final List<DesignerProjectCardModel> list;

  const DesignerHorizontalCards({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        separatorBuilder: (_, __) => SizedBox(width: 16.w),
        itemBuilder: (context, index) {
          return DesignerProjectCard(data: list[index]);
        },
      ),
    );
  }
}
