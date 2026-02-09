import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class InfoNoticeBanner extends StatelessWidget {
  const InfoNoticeBanner({super.key});

  static const String _message =
      'سيتم إخطارك فور الموافقه للمشروع واتخاذ القرار المناسب، يرجى متابعة حالة المشروع بشكل دوري.';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColor.infoBannerBg,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 22.sp, color: AppColor.infoBannerText),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              _message,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: AppColor.infoBannerText,
                fontFamily: 'Cairo',
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
