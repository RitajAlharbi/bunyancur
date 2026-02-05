import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class AppDropdownField extends StatelessWidget {
  final String hintText;
  final String? value;
  final VoidCallback onTap;

  const AppDropdownField({
    super.key,
    required this.hintText,
    required this.onTap,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    final displayText = value?.isNotEmpty == true ? value! : hintText;
    final displayStyle = value?.isNotEmpty == true
        ? AppTextStyles.body
        : AppTextStyles.body.copyWith(color: AppColor.grey400);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColor.grey100,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColor.grey200),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/Icondown.svg',
              width: 16.w,
              height: 16.h,
              colorFilter: const ColorFilter.mode(
                AppColor.grey500,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                displayText,
                textAlign: TextAlign.right,
                style: displayStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
