import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onFavoriteTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Image.asset(
              product.imageUrl,
              width: double.infinity,
              height: 110.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 110.h,
                  color: AppColor.grey200,
                  child: Icon(Icons.image, size: 40.sp, color: AppColor.grey400),
                );
              },
            ),
          ),
          SizedBox(height: 10.h),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  product.title,
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColor.orange900,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  product.sellerName,
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.caption12,
                ),
                const Spacer(),
                Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    Text(
                      '${product.price} ريال',
                      style: AppTextStyles.price,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: onFavoriteTap,
                      child: SvgPicture.asset(
                        'assets/icons/Heart.svg',
                        width: 20.w,
                        height: 20.h,
                        colorFilter: ColorFilter.mode(
                          product.isFavorite
                              ? AppColor.orange900
                              : AppColor.grey400,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
