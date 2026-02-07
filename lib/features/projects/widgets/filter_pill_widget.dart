import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../model/filter_model.dart';

class FilterPillWidget extends StatelessWidget {
  final FilterType type;
  final bool isActive;
  final VoidCallback onTap;
  final Color? activeColor;
  final Color? borderColor;
  final Color? inactiveTextColor;

  const FilterPillWidget({
    super.key,
    required this.type,
    required this.isActive,
    required this.onTap,
    this.activeColor,
    this.borderColor,
    this.inactiveTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final active = activeColor ?? AppColor.availableProjectsPrimary;
    final border = borderColor ?? AppColor.availableProjectsBorder;
    final inactiveText = inactiveTextColor ?? AppColor.availableProjectsTitle;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: isActive ? active : AppColor.white,
            borderRadius: BorderRadius.circular(24.r),
            border: isActive ? null : Border.all(color: border, width: 1),
          ),
          child: Text(
            type.label,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: isActive ? AppColor.white : inactiveText,
              fontFamily: 'Cairo',
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
