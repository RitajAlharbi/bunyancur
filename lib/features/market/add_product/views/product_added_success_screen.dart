import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../models/product_form_model.dart';
import '../widgets/product_summary_card.dart';

class ProductAddedSuccessScreen extends StatelessWidget {
  final ProductFormModel? form;

  const ProductAddedSuccessScreen({super.key, this.form});

  String _formatPrice(String? price) {
    if (price == null || price.trim().isEmpty) {
      return '200 ريال';
    }
    return price.contains('ريال') ? price : '$price ريال';
  }

  @override
  Widget build(BuildContext context) {
    final title = (form?.name.trim().isNotEmpty ?? false)
        ? form!.name
        : 'مواد بناء';
    final category = form?.categoryId?.isNotEmpty == true
        ? form!.categoryId!
        : 'حديد';
    final city = form?.cityId?.isNotEmpty == true ? form!.cityId! : 'الخرج';

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 150.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                    color: AppColor.grey100,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 104.w,
                      height: 104.h,
                      decoration: BoxDecoration(
                        color: AppColor.orange900,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/Icondone.svg',
                          width: 56.w,
                          height: 56.h,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'تم إضافة المنتج بنجاح',
                  style: AppTextStyles.title,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Text(
                  'المنتج متاح الآن في السوق',
                  style: AppTextStyles.body,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                ProductSummaryCard(
                  title: title,
                  price: _formatPrice(form?.price),
                  category: category,
                  city: city,
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.marketScreen,
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.orange900,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Text(
                      'العودة للسوق',
                      style: AppTextStyles.body.copyWith(
                        color: AppColor.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.addProduct,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColor.orange900),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/Icon-1.svg',
                          width: 18.w,
                          height: 18.h,
                          colorFilter: const ColorFilter.mode(
                            AppColor.orange900,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'إضافة منتج آخر',
                          style: AppTextStyles.body.copyWith(
                            color: AppColor.orange900,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
