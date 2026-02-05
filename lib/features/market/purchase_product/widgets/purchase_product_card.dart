import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../models/purchase_product_model.dart';

class PurchaseProductCard extends StatelessWidget {
  final PurchaseProductModel product;

  const PurchaseProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 100.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product.title,
                    textAlign: TextAlign.right,
                    style: AppTextStyles.body.copyWith(
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    product.priceLabel,
                    textAlign: TextAlign.right,
                    style: AppTextStyles.price.copyWith(fontSize: 18.sp),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'البائع: ${product.sellerName}',
                    textAlign: TextAlign.right,
                    style: AppTextStyles.caption12.copyWith(
                      color: AppColor.grey600,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        product.rating.toStringAsFixed(1),
                        textAlign: TextAlign.right,
                        style: AppTextStyles.caption12.copyWith(
                          color: AppColor.orange900,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      SvgPicture.asset(
                        'assets/icons/Iconstart.svg',
                        width: 14.w,
                        height: 14.h,
                        colorFilter: const ColorFilter.mode(
                          AppColor.orange900,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            width: 100.w,
            height: 100.h,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColor.grey100,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Image.asset(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
