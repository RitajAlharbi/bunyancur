import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class AttachmentCard extends StatelessWidget {
  final String? attachmentName;
  final VoidCallback onTap;

  const AttachmentCard({
    super.key,
    required this.attachmentName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColor.grey200),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/Iconfile.svg',
              width: 22.w,
              height: 22.h,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    attachmentName ?? 'إضافة مرفق أو شهادة ضمان',
                    textAlign: TextAlign.right,
                    style: AppTextStyles.body.copyWith(
                      color: AppColor.orange900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    attachmentName ?? 'صورة أو PDF',
                    textAlign: TextAlign.right,
                    style: AppTextStyles.caption12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
