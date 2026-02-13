import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class OrderSummaryCard extends StatelessWidget {
  final String basePrice;
  final String quantityLabel;
  final String totalLabel;

  const OrderSummaryCard({
    super.key,
    required this.basePrice,
    required this.quantityLabel,
    required this.totalLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.fromSTEB(16.w, 16.h, 16.w, 12.h),
      decoration: BoxDecoration(
        color: AppColor.grey100,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              'ملخص الطلب',
              textAlign: TextAlign.right,
              style: AppTextStyles.body.copyWith(
                color: AppColor.grey600,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'السعر الأساسي',
                style: AppTextStyles.body.copyWith(color: AppColor.grey600),
                textAlign: TextAlign.right,
              ),
              Text(
                basePrice,
                style: AppTextStyles.body.copyWith(color: AppColor.grey600),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الكمية',
                style: AppTextStyles.body.copyWith(color: AppColor.grey600),
                textAlign: TextAlign.right,
              ),
              Text(
                quantityLabel,
                style: AppTextStyles.body.copyWith(color: AppColor.grey600),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Divider(color: AppColor.grey200, height: 1.h),
          SizedBox(height: 8.h),
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الإجمالي',
                style: AppTextStyles.body.copyWith(
                  color: AppColor.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
              Text(
                totalLabel,
                textAlign: TextAlign.left,
                style: AppTextStyles.price.copyWith(
                  color: AppColor.orange900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
