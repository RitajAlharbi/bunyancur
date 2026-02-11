import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../model/offer_vm.dart';

class OfferCard extends StatelessWidget {
  final OfferVM offer;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  const OfferCard({
    super.key,
    required this.offer,
    this.onAccept,
    this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: ShapeDecoration(
        color: const Color(0xFFF8FBFC),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 0.53,
            color: Color(0xFFF2F4F6),
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _InfoRow(
            icon: Icons.person_outline,
            label: offer.contractorName,
          ),
          SizedBox(height: 6.h),
          _InfoRow(
            icon: Icons.account_balance_wallet_outlined,
            label: offer.offerPrice,
            labelStyle: AppTextStyles.body.copyWith(
              color: AppColor.orange900,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 6.h),
          _InfoRow(
            icon: Icons.schedule_outlined,
            label: offer.duration,
          ),
          SizedBox(height: 6.h),
          Row(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.description_outlined, size: 16.r, color: AppColor.grey500),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  offer.shortDescription,
                  style: AppTextStyles.body.copyWith(
                    color: const Color(0xFF495565),
                    fontSize: 14.sp,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _OutlinedButton(label: 'رفض', onPressed: onReject ?? () {}),
              _FilledButton(label: 'قبول', onPressed: onAccept ?? () {}),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextStyle? labelStyle;

  const _InfoRow({
    required this.icon,
    required this.label,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Icon(icon, size: 16.r, color: AppColor.grey500),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            label,
            style: labelStyle ?? AppTextStyles.body.copyWith(
              color: const Color(0xFF495565),
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _OutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _OutlinedButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColor.orange900,
        side: const BorderSide(width: 0.53, color: AppColor.orange900),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      ),
      child: Text(
        label,
        style: AppTextStyles.body.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColor.orange900,
        ),
      ),
    );
  }
}

class _FilledButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _FilledButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: AppColor.orange900,
        foregroundColor: AppColor.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      ),
      child: Text(
        label,
        style: AppTextStyles.body.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColor.white,
        ),
      ),
    );
  }
}
