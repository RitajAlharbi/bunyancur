import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class ProductImagePickerCard extends StatelessWidget {
  final int imageCount;
  final VoidCallback onTap;
  final VoidCallback? onRemoveTap;

  const ProductImagePickerCard({
    super.key,
    required this.imageCount,
    required this.onTap,
    this.onRemoveTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20.r),
          child: Container(
            height: 168.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: AppColor.grey200),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                  child: Container(
                    width: 52.w,
                    height: 52.h,
                    decoration: BoxDecoration(
                      color: AppColor.grey100,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/IconDonl.svg',
                        width: 24.w,
                        height: 24.h,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'أضف صورة المنتج',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body.copyWith(
                      color: AppColor.orange900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (imageCount > 0) ...[
                  SizedBox(height: 6.h),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'تم اختيار $imageCount صور',
                      textAlign: TextAlign.right,
                      style: AppTextStyles.caption12,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Center(
                    child: TextButton.icon(
                      onPressed: onRemoveTap,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                      ),
                      icon: Icon(
                        Icons.delete_outline_rounded,
                        size: 18.r,
                        color: AppColor.orange900,
                      ),
                      label: Text(
                        'حذف آخر صورة',
                        style: AppTextStyles.caption12.copyWith(
                          color: AppColor.orange900,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
