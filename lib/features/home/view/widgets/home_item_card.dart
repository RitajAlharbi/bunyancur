import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_colors.dart';
import '../../model/home_item_model.dart';

class HomeItemCard extends StatelessWidget {
  final HomeItemModel item;
  final VoidCallback? onTap;

  const HomeItemCard({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      width: 180.w,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 60,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: _buildImage(),
              ),
              Positioned(
                top: 12.h,
                left: 12.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xffF0F0F0),
                    borderRadius: BorderRadius.circular(100.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 100,
                        offset: const Offset(0, 20),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, size: 10.sp, color: AppColor.orange900),
                      SizedBox(width: 4.w),
                      Text(
                        item.rating.toStringAsFixed(1),
                        style: GoogleFonts.cairo(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColor.orange900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            item.name,
            style: GoogleFonts.cairo(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColor.orange900,
            ),
            textAlign: TextAlign.right,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: SvgPicture.asset(
                    'assets/icons/Heart.svg',
                    width: 20.w,
                    height: 20.h,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  item.location,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: GoogleFonts.cairo(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColor.grey700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildImage() {
    final url = item.imageUrl;
    if (url == null || url.isEmpty) {
      return _buildFallback();
    }
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return CachedNetworkImage(
        imageUrl: url,
        width: double.infinity,
        height: 154.h,
        fit: BoxFit.cover,
        placeholder: (_, __) => _buildFallback(),
        errorWidget: (_, __, ___) => _buildFallback(),
      );
    }
    return Image.asset(
      url,
      width: double.infinity,
      height: 154.h,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => _buildFallback(),
    );
  }

  Widget _buildFallback() {
    return Container(
      width: double.infinity,
      height: 154.h,
      decoration: BoxDecoration(
        color: AppColor.grey200,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Icon(Icons.business, size: 48.sp, color: AppColor.grey400),
    );
  }
}
