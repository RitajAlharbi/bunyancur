import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class AboutCard extends StatelessWidget {
  final String bio;

  const AboutCard({super.key, required this.bio});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: ShapeDecoration(
        color: AppColor.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.53, color: AppColor.borderLight),
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: [
          BoxShadow(
            color: AppColor.shadowLight,
            blurRadius: 3,
            offset: const Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(
                'assets/icons/Icon4.svg',
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  AppColor.orange900,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'نبذة عن الشركة',
                style: AppTextStyles.body.copyWith(
                  color: AppColor.headingDark,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            bio.isNotEmpty ? bio : 'لا توجد نبذة متاحة.',
            style: AppTextStyles.body.copyWith(
              color: AppColor.bioText,
              fontWeight: FontWeight.w400,
              height: 1.80,
            ),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
}
