import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class CreateProjectPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const CreateProjectPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.orange900,
          disabledBackgroundColor: AppColor.grey200,
          disabledForegroundColor: AppColor.grey500,
          foregroundColor: AppColor.white,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
