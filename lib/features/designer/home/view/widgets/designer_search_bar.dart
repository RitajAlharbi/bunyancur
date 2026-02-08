import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/app_colors.dart';

class DesignerSearchBar extends StatelessWidget {
  const DesignerSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: AppColor.grey100,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/Filter.svg',
            width: 24.w,
            height: 24.h,
            colorFilter: ColorFilter.mode(AppColor.grey400, BlendMode.srcIn),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'البحث',
              textAlign: TextAlign.right,
              style: GoogleFonts.cairo(
                fontSize: 14.sp,
                color: AppColor.grey400,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          SvgPicture.asset(
            'assets/icons/Search.svg',
            width: 24.w,
            height: 24.h,
            colorFilter: ColorFilter.mode(AppColor.grey400, BlendMode.srcIn),
          ),
        ],
      ),
    );
  }
}
