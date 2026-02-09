import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../model/review_model.dart';

class RatingSection extends StatelessWidget {
  final ReviewModel review;

  const RatingSection({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                Icons.star,
                size: 20.sp,
                color: const Color(0xFFFFD700),
              ),
              SizedBox(width: 8.w),
              Text(
                'تقييم العميل',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: List.generate(
              5,
              (index) => Padding(
                padding: EdgeInsets.only(left: index > 0 ? 6.w : 0),
                child: Icon(
                  index < review.rating ? Icons.star : Icons.star_border,
                  size: 20.sp,
                  color: const Color(0xFFFFD700), // Gold
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            review.comment,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColor.black,
              fontFamily: 'Cairo',
              height: 1.5,
            ),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Text(
                '— ',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.grey600,
                  fontFamily: 'Cairo',
                ),
              ),
              Text(
                review.clientName,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.grey600,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
