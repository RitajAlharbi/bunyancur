import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class CreateProjectUploadArea extends StatelessWidget {
  final String title;
  final IconData titleIcon;
  final String actionText;
  final String allowedTypesText;
  final bool isEmpty;
  final Widget? content;
  final VoidCallback onTap;

  const CreateProjectUploadArea({
    super.key,
    required this.title,
    required this.titleIcon,
    required this.actionText,
    required this.allowedTypesText,
    required this.isEmpty,
    required this.onTap,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                color: AppColor.orange900.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                titleIcon,
                color: AppColor.orange900,
                size: 18.sp,
              ),
            ),
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
        Material(
          color: AppColor.grey100,
          borderRadius: BorderRadius.circular(20.r),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: AppColor.grey200),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: isEmpty
                    ? _UploadPlaceholder(
                        actionText: actionText,
                        allowedTypesText: allowedTypesText,
                      )
                    : content ?? const SizedBox.shrink(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _UploadPlaceholder extends StatelessWidget {
  final String actionText;
  final String allowedTypesText;

  const _UploadPlaceholder({
    required this.actionText,
    required this.allowedTypesText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('upload-placeholder'),
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 44.w,
          height: 44.w,
          decoration: BoxDecoration(
            color: AppColor.grey200,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.file_upload_outlined,
            color: AppColor.grey500,
            size: 22.sp,
          ),
        ),
        SizedBox(height: 12.h),
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
    );
  }
}
