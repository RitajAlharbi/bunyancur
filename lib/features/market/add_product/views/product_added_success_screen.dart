import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../models/product_form_model.dart';

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
            padding: EdgeInsetsDirectional.fromSTEB(16.w, 20.h, 16.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _SuccessHeader(),
                SizedBox(height: 16.h),
                _ProductSummaryCard(
                  title: title,
                  price: _formatPrice(form?.price),
                  category: category,
                  city: city,
                ),
                SizedBox(height: 24.h),
                _ActionButton(
                  text: 'العودة للسوق',
                  textColor: AppColor.white,
                  fillColor: AppColor.orange900,
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.marketScreen,
                      (route) => false,
                    );
                  },
                ),
                SizedBox(height: 12.h),
                _ActionButton(
                  text: 'إضافة منتج آخر',
                  textColor: AppColor.slate500,
                  borderColor: AppColor.grey200,
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.addProduct,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SuccessHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 128.w,
          height: 128.h,
          decoration: const BoxDecoration(
            color: AppColor.success100,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: 96.w,
              height: 96.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColor.success500, AppColor.success600],
                ),
              ),
              child: Icon(
                Icons.check_circle_outline_rounded,
                size: 46.r,
                color: AppColor.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'تم إضافة المنتج بنجاح',
          textAlign: TextAlign.center,
          style: AppTextStyles.body.copyWith(
            color: AppColor.darkText,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          'المنتج متاح الآن في السوق',
          textAlign: TextAlign.center,
          style: AppTextStyles.body.copyWith(
            color: AppColor.secondaryText,
            fontSize: 15.sp,
          ),
        ),
      ],
    );
  }
}

class _ProductSummaryCard extends StatelessWidget {
  final String title;
  final String price;
  final String category;
  final String city;

  const _ProductSummaryCard({
    required this.title,
    required this.price,
    required this.category,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(20.w, 20.h, 20.w, 20.h),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.grey200, width: 0.53),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowMedium,
            blurRadius: 3.r,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              'ملخص المنتج',
              textAlign: TextAlign.right,
              style: AppTextStyles.body.copyWith(
                color: AppColor.darkText,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            child: Text(
              title,
              textAlign: TextAlign.right,
              style: AppTextStyles.body.copyWith(
                color: AppColor.slate700,
                fontSize: 14.sp,
              ),
            ),
          ),
          SizedBox(height: 14.h),
          _SummaryInfoRow(label: 'السعر', value: price, highlight: true),
          SizedBox(height: 10.h),
          _SummaryInfoRow(label: 'الفئة', value: category),
          SizedBox(height: 10.h),
          _SummaryInfoRow(label: 'المدينة', value: city),
        ],
      ),
    );
  }
}

class _SummaryInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;

  const _SummaryInfoRow({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          textAlign: TextAlign.right,
          style: AppTextStyles.body.copyWith(
            color: AppColor.slate500,
            fontSize: 14.sp,
          ),
        ),
        Text(
          value,
          textAlign: TextAlign.left,
          style: AppTextStyles.body.copyWith(
            color: highlight ? AppColor.success600 : AppColor.slate700,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color textColor;
  final Color? borderColor;
  final Color? fillColor;

  const _ActionButton({
    required this.text,
    required this.onTap,
    required this.textColor,
    this.borderColor,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    final hasFill = fillColor != null;
    return SizedBox(
      height: 56.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: fillColor ?? AppColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
            side: BorderSide(
              color: hasFill ? Colors.transparent : (borderColor ?? AppColor.grey200),
              width: hasFill ? 0 : 1.6,
            ),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppTextStyles.body.copyWith(
            color: textColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
