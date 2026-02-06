import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/routing/routes.dart';
import '../controllers/product_details_controller.dart';
import '../models/product_details_model.dart';
import '../widgets/product_detail_info_row.dart';
import '../../purchase_product/models/purchase_product_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductDetailsModel? product;

  const ProductDetailsScreen({super.key, this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late final ProductDetailsController controller;

  @override
  void initState() {
    super.initState();
    controller = ProductDetailsController(product: widget.product);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = controller.product;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsetsDirectional.fromSTEB(20.w, 16.h, 20.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 6.h),
                Row(
                  children: [
                    const SizedBox(width: 40),
                    Expanded(
                      child: Text(
                        'تفاصيل المنتج',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.title,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40.w,
                        height: 40.h,
                        padding: EdgeInsetsDirectional.all(8.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Transform.rotate(
                          angle: 3.14159,
                          child: SvgPicture.asset(
                            'assets/icons/Icon-3.svg',
                            width: 24.w,
                            height: 24.h,
                            colorFilter: const ColorFilter.mode(
                              AppColor.orange900,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Container(
                  width: double.infinity,
                  height: 317.h,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: AppColor.grey100,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Image.asset(
                    product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsetsDirectional.all(20.w),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.black.withValues(alpha: 0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        product.title,
                        textAlign: TextAlign.right,
                        style: AppTextStyles.title.copyWith(
                          color: AppColor.black,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        padding: EdgeInsetsDirectional.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.grey100,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          product.categoryLabel,
                          style: AppTextStyles.caption12.copyWith(
                            color: AppColor.grey600,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'الوصف',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.body.copyWith(
                          color: AppColor.grey600,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        product.description,
                        textAlign: TextAlign.right,
                        style: AppTextStyles.body.copyWith(
                          color: AppColor.grey600,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      ProductDetailInfoRow(
                        iconPath: 'assets/icons/Iconbox.svg',
                        label: product.quantityLabel,
                      ),
                      SizedBox(height: 8.h),
                      ProductDetailInfoRow(
                        iconPath: 'assets/icons/Iconloca.svg',
                        label: product.city,
                      ),
                      SizedBox(height: 12.h),
                      Divider(color: AppColor.grey200, height: 1.h),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.priceLabel,
                            style: AppTextStyles.price,
                          ),
                          Text(
                            'السعر',
                            style: AppTextStyles.body.copyWith(
                              color: AppColor.grey600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsetsDirectional.fromSTEB(
                    20.w,
                    20.h,
                    20.w,
                    16.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.black.withValues(alpha: 0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'البائع',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.body.copyWith(
                          color: AppColor.grey600,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20.r,
                            backgroundImage: AssetImage(product.sellerAvatar),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  product.sellerName,
                                  textAlign: TextAlign.right,
                                  style: AppTextStyles.body.copyWith(
                                    color: AppColor.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  product.sellerRole,
                                  textAlign: TextAlign.right,
                                  style: AppTextStyles.caption12.copyWith(
                                    color: AppColor.grey600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            Routes.purchaseProduct,
                            arguments: PurchaseProductModel(
                              title: product.title,
                              priceLabel: product.priceLabel,
                              sellerName: product.sellerName,
                              imageUrl: product.imageUrl,
                              rating: 4.8,
                            ),
                          );
                        },
                        icon: SvgPicture.asset(
                          'assets/icons/Iconshop.svg',
                          width: 20.w,
                          height: 20.h,
                          colorFilter: const ColorFilter.mode(
                            AppColor.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        label: Text(
                          'شراء المنتج',
                          style: AppTextStyles.body.copyWith(
                            color: AppColor.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.orange900,
                          padding: EdgeInsetsDirectional.symmetric(
                            vertical: 14.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/icons/Iconmasg.svg',
                          width: 20.w,
                          height: 20.h,
                          colorFilter: const ColorFilter.mode(
                            AppColor.orange900,
                            BlendMode.srcIn,
                          ),
                        ),
                        label: Text(
                          'مراسلة البائع',
                          style: AppTextStyles.body.copyWith(
                            color: AppColor.orange900,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColor.orange900, width: 1.5),
                          padding: EdgeInsetsDirectional.symmetric(
                            vertical: 14.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'يمكنك عرض منتجاتك الفائضة للبيع بعد مراجعتها من الإدارة.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.caption12.copyWith(
                      color: AppColor.grey400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
