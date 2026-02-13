import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class ThankYouDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const ThankYouDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
        backgroundColor: Colors.transparent,
        child: Container(
          width: 350.w,
          constraints: BoxConstraints(minHeight: 280.h),
          padding: EdgeInsetsDirectional.fromSTEB(24.w, 24.h, 24.w, 24.h),
          decoration: ShapeDecoration(
            color: AppColor.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 0.53,
                color: AppColor.borderLight,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            shadows: const [
              BoxShadow(
                color: AppColor.shadowLight,
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64.w,
                height: 64.h,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(0.5, 0),
                    end: Alignment(0.5, 1),
                    colors: [AppColor.success500, AppColor.success600],
                  ),
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Icon(
                  Icons.check_rounded,
                  size: 32.r,
                  color: AppColor.white,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'شكراً لتقييمك!',
                textAlign: TextAlign.center,
                style: AppTextStyles.title.copyWith(
                  color: AppColor.darkText,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'تم إرسال تقييمك بنجاح. رأيك يساعد الآخرين في اتخاذ قراراتهم',
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(
                  color: AppColor.slate500,
                  fontSize: 14.sp,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.orange900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                  ),
                  child: Text(
                    'حسناً',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body.copyWith(
                      color: AppColor.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
