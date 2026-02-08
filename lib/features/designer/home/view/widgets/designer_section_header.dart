import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/app_colors.dart';

class DesignerSectionHeader extends StatelessWidget {
  final String title;
  final String actionText;

  const DesignerSectionHeader({
    super.key,
    required this.title,
    required this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {},
          child: Text(
            actionText,
            style: GoogleFonts.cairo(
              fontSize: 14.sp,
              color: AppColor.orange900,
            ),
          ),
        ),
        const Spacer(),
        Text(
          title,
          style: GoogleFonts.cairo(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.orange900,
          ),
        ),
      ],
    );
  }
}
