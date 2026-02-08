import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../model/designer_home_model.dart';

class DesignerProjectCard extends StatelessWidget {
  final DesignerProjectCardModel data;

  const DesignerProjectCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190.w,
      padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 60,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: _buildImage(),
          ),
          SizedBox(height: 12.h),
          Text(
            data.title,
            textAlign: TextAlign.right,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.cairo(
              fontSize: 15.sp,
              height: 1.3,
              fontWeight: FontWeight.w700,
              color: AppColor.grey700,
            ),
          ),
          if (data.subtitle1 != null) ...[
            SizedBox(height: 6.h),
            Text(
              data.subtitle1!,
              textAlign: TextAlign.right,
              style: GoogleFonts.cairo(
                fontSize: 10.sp,
                letterSpacing: 0.2,
                fontWeight: FontWeight.w500,
                color: AppColor.grey700,
              ),
            ),
          ],
          if (data.subtitle2 != null) ...[
            SizedBox(height: 3.h),
            Text(
              data.subtitle2!,
              textAlign: TextAlign.right,
              style: GoogleFonts.cairo(
                fontSize: 10.sp,
                letterSpacing: 0.2,
                fontWeight: FontWeight.w500,
                color: AppColor.grey700,
              ),
            ),
          ],
          const Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 24.h,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: AppColor.orange900,
                borderRadius: BorderRadius.circular(100.r),
              ),
              alignment: Alignment.center,
              child: Text(
                data.actionText,
                style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontSize: 12.sp,
                  height: 2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (data.imagePathOrUrl.startsWith('http')) {
      return Image.network(
        data.imagePathOrUrl,
        height: 154.h,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _placeholder(),
      );
    }
    return Image.asset(
      data.imagePathOrUrl,
      height: 154.h,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _placeholder(),
    );
  }

  Widget _placeholder() {
    return Container(
      height: 154.h,
      width: double.infinity,
      color: AppColor.grey200,
      alignment: Alignment.center,
      child: Icon(Icons.image_not_supported, size: 40.sp, color: AppColor.grey400),
    );
  }
}
