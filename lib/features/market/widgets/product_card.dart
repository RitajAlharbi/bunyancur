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
    final priceText = _formatPrice(product.price);
    final imagePath = product.imageUrl;
    final isRemote = imagePath.startsWith('http');
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0C000000),
            blurRadius: 8.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: AspectRatio(
                aspectRatio: 1,
                child: isRemote
                    ? Image.network(
                        imagePath,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColor.grey200,
                            child: Icon(
                              Icons.image,
                              size: 40.sp,
                              color: AppColor.grey400,
                            ),
                          );
                        },
                      )
                    : Image.asset(
                        imagePath,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColor.grey200,
                            child: Icon(
                              Icons.image,
                              size: 40.sp,
                              color: AppColor.grey400,
                            ),
                          );
                        },
                      ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            child: Text(
              product.title,
              textAlign: TextAlign.right,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.body.copyWith(
                color: const Color(0xFF3B3B3B),
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          SizedBox(
            width: double.infinity,
            child: Text(
              product.sellerName,
              textAlign: TextAlign.right,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.caption12.copyWith(
                color: const Color(0xFF8C8C8C),
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
          const Spacer(),
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$priceText ريال',
                style: AppTextStyles.price.copyWith(
                  color: const Color(0xFFAF5500),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
              ),
              GestureDetector(
                onTap: onFavoriteTap,
                child: Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                  alignment: Alignment.center,
                  child: product.isFavorite
                      ? Icon(
                          Icons.favorite,
                          size: 20.sp,
                          color: AppColor.orange900,
                        )
                      : SvgPicture.asset(
                          'assets/icons/Heart.svg',
                          width: 20.w,
                          height: 20.h,
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatPrice(double price) {
    if (price == price.roundToDouble()) {
      return price.toStringAsFixed(0);
    }
    return price.toStringAsFixed(2);
  }
}
