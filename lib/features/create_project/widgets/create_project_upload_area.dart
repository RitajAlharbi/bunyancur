import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class CreateProjectUploadArea extends StatelessWidget {
  final String title;
  final IconData titleIcon;
  final String actionText;
  final String allowedTypesText;
  final bool isEmpty;
  final VoidCallback onTap;
  final Widget content;

  const CreateProjectUploadArea({
    super.key,
    required this.title,
    required this.titleIcon,
    required this.actionText,
    required this.allowedTypesText,
    required this.isEmpty,
    required this.onTap,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColor.grey100,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(titleIcon, color: AppColor.orange900, size: 18.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.right,
                  style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          if (isEmpty)
            InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(14.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: AppColor.grey200),
                ),
                child: Column(
                  children: [
                    Text(
                      actionText,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      allowedTypesText,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.caption12,
                    ),
                  ],
                ),
              ),
            )
          else
            Column(
              children: [
                content,
                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: onTap,
                    child: Text(
                      actionText,
                      style: AppTextStyles.caption12.copyWith(
                        color: AppColor.orange900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
