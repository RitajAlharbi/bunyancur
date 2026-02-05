import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class ProductDetailInfoRow extends StatelessWidget {
  final String iconPath;
  final String label;

  const ProductDetailInfoRow({
    super.key,
    required this.iconPath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        SvgPicture.asset(
          iconPath,
          width: 18.w,
          height: 18.h,
          colorFilter: const ColorFilter.mode(
            AppColor.orange900,
            BlendMode.srcIn,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            label,
            textAlign: TextAlign.right,
            style: AppTextStyles.body.copyWith(
              color: AppColor.grey600,
            ),
          ),
        ),
      ],
    );
  }
}
