import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class AdminStatusFilterDropdown extends StatelessWidget {
  final String value;
  final List<String> options;
  final ValueChanged<String?> onChanged;

  const AdminStatusFilterDropdown({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColor.grey100,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          alignment: Alignment.centerRight,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: AppColor.grey500,
          ),
          dropdownColor: AppColor.white,
          borderRadius: BorderRadius.circular(16.r),
          selectedItemBuilder: (context) => options
              .map(
                (item) => Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    item,
                    textAlign: TextAlign.right,
                    style: AppTextStyles.body.copyWith(color: AppColor.black),
                  ),
                ),
              )
              .toList(),
          items: options
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  alignment: Alignment.centerRight,
                  child: Text(
                    item,
                    textAlign: TextAlign.right,
                    style: AppTextStyles.body.copyWith(color: AppColor.black),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

