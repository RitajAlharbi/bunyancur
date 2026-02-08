import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/app_colors.dart';

class DesignerHomeHeader extends StatelessWidget {
  const DesignerHomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CircleIconButton(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              SvgPicture.asset(
                'assets/icons/notfication.svg',
                width: 24.w,
                height: 24.h,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 6.w,
                  height: 6.h,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        _CircleIconButton(
          child: SvgPicture.asset(
            'assets/icons/Heart.svg',
            width: 24.w,
            height: 24.h,
          ),
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'مرحبا لينا 👋',
              style: GoogleFonts.cairo(
                fontSize: 16.sp,
                color: AppColor.grey600,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'لينا احمد',
              style: GoogleFonts.cairo(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.orange900,
              ),
            ),
          ],
        ),
        SizedBox(width: 12.w),
        CircleAvatar(
          radius: 24.r,
          backgroundColor: Colors.transparent,
          child: Image.asset(
            'assets/icons/avatar.png',
            width: 40.w,
            height: 40.h,
            errorBuilder: (_, __, ___) => Icon(Icons.person, size: 32.sp),
          ),
        ),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final Widget child;

  const _CircleIconButton({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.w,
      height: 48.h,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.grey200),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}
