import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../model/professional_review_vm.dart';

class ReviewsList extends StatelessWidget {
  final List<ProfessionalReviewVm> reviews;

  const ReviewsList({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: reviews.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        return _ReviewCard(review: reviews[index]);
      },
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final ProfessionalReviewVm review;

  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: ShapeDecoration(
        color: AppColor.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.53.w, color: AppColor.borderLight),
          borderRadius: BorderRadius.circular(16.r),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: TextDirection.rtl,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                textDirection: TextDirection.rtl,
                children: [
                  _buildAvatar(),
                  SizedBox(width: 8.w),
                  Text(
                    review.reviewerName,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColor.darkText,
                    ),
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
              Text(
                review.timeLabel,
                style: AppTextStyles.caption12.copyWith(
                  color: AppColor.grey500,
                ),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(
              5,
              (i) => Icon(
                i < review.starCount ? Icons.star : Icons.star_border,
                size: 16.sp,
                color: AppColor.orange900,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            review.comment,
            style: AppTextStyles.body.copyWith(
              color: AppColor.grey700,
              height: 1.5,
            ),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    final initial = review.reviewerName.isNotEmpty
        ? review.reviewerName.substring(0, 1).toUpperCase()
        : '?';
    return Container(
      width: 36.w,
      height: 36.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColor.grey100,
      ),
      child: Center(
        child: Text(
          initial,
          style: AppTextStyles.caption12.copyWith(
            color: AppColor.orange900,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
