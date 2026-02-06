import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class ProductSummaryCard extends StatelessWidget {
  final String title;
  final String price;
  final String category;
  final String city;

  const ProductSummaryCard({
    super.key,
    required this.title,
    required this.price,
    required this.category,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.grey100,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: AppTextStyles.body.copyWith(
              color: AppColor.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          _SummaryRow(label: 'السعر', value: price),
          SizedBox(height: 8.h),
          _SummaryRow(label: 'الفئة', value: category),
          SizedBox(height: 8.h),
          _SummaryRow(label: 'المدينة', value: city),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          value,
          textAlign: TextAlign.left,
          style: AppTextStyles.body.copyWith(
            color: AppColor.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.right,
          style: AppTextStyles.body.copyWith(color: AppColor.grey600),
        ),
      ],
    );
  }
}
