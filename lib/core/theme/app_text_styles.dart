import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle title = GoogleFonts.cairo(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: AppColor.orange900,
  );

  static TextStyle sectionTitle = GoogleFonts.cairo(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: AppColor.orange900,
  );

  static TextStyle body = GoogleFonts.cairo(
    fontSize: 14.sp,
    color: AppColor.grey700,
  );

  static TextStyle caption12 = GoogleFonts.cairo(
    fontSize: 12.sp,
    color: AppColor.grey600,
  );

  static TextStyle caption10 = GoogleFonts.cairo(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.grey700,
  );

  static TextStyle price = GoogleFonts.cairo(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: AppColor.orange900,
  );
}
