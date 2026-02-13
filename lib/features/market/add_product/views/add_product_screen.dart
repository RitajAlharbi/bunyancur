import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/routing/routes.dart';
import '../controller/add_product_controller.dart';
import '../widgets/app_text_field.dart';
import '../widgets/inline_dropdown_field.dart';
import '../widgets/product_image_picker_card.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late final AddProductController controller;

  @override
  void initState() {
    super.initState();
    controller = AddProductController();
    controller.loadCategories();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColor.orange900,
        content: Text(
          message,
          style: AppTextStyles.body.copyWith(color: AppColor.white),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    final errorMessage = await controller.submitProduct();
    if (!mounted) return;
    if (errorMessage != null) {
      _showSnackBar(errorMessage);
      return;
    }
    Navigator.pushNamed(
      context,
      Routes.productAddedSuccess,
      arguments: controller.form,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              return SingleChildScrollView(
                padding: EdgeInsetsDirectional.fromSTEB(20.w, 16.h, 20.w, 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 6.h),
                    Row(
                      children: [
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
                        Expanded(
                          child: Text(
                            'إضافة منتج',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.title.copyWith(fontSize: 22.sp),
                          ),
                        ),
                        const SizedBox(width: 40),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'أضف صور المنتج ومواصفاته بدقة لعرضه في السوق.',
                        style: AppTextStyles.body,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'صور المنتج',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.body.copyWith(
                          color: AppColor.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    ProductImagePickerCard(
                      imageCount: controller.form.images.length,
                      onTap: () async {
                        final error = await controller.pickImages();
                        if (!mounted || error == null) return;
                        _showSnackBar(error);
                      },
                      onRemoveTap: controller.form.images.isEmpty
                          ? null
                          : controller.removeLastImage,
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'يمكنك رفع حتى 3 صور للمنتج',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.caption12,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'التفاصيل الأساسية',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.body.copyWith(
                          color: AppColor.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'اسم المنتج',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.body,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    AppTextField(
                      controller: controller.nameController,
                      hintText: 'مثال: "سقالات كورية"',
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'الوصف',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.body,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    AppTextField(
                      controller: controller.descriptionController,
                      hintText: 'مثال: "سقالات كورية متكاملة بجودة عالية وسهولة في التركيب."',
                      maxLines: 4,
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'الفئة / النوع',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.body,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    if (controller.isLoadingCategories) ...[
                      InlineDropdownField(
                        hintText: 'جاري تحميل الفئات...',
                        value: null,
                        items: const ['جاري تحميل الفئات...'],
                        onChanged: (_) {},
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 14.w,
                            height: 14.h,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColor.orange900,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'جاري تحميل الفئات...',
                            style: AppTextStyles.caption12.copyWith(
                              color: AppColor.grey500,
                            ),
                          ),
                        ],
                      ),
                    ] else if (controller.categoriesError != null) ...[
                      InlineDropdownField(
                        hintText: 'اختر الفئة',
                        value: null,
                        items: const ['تعذر تحميل الفئات'],
                        onChanged: (_) {},
                      ),
                      SizedBox(height: 8.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: controller.loadCategories,
                          child: Text(
                            'تعذر تحميل الفئات، إعادة المحاولة',
                            style: AppTextStyles.caption12.copyWith(
                              color: AppColor.orange900,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ] else ...[
                      InlineDropdownField(
                        hintText: 'اختر الفئة',
                        value: controller.form.categoryName,
                        items: controller.categoryNames,
                        onChanged: (selectedName) {
                          final selectedId =
                              controller.categoryIdByName(selectedName);
                          if (selectedId == null) return;
                          controller.setSelectedCategory(selectedId);
                        },
                      ),
                    ],
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'الكمية المتوفرة',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.body,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    AppTextField(
                      controller: controller.quantityController,
                      hintText: 'مثال: "10 قطع" أو "50 مترًا"',
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'السعر (ريال)',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.body,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    AppTextField(
                      controller: controller.priceController,
                      hintText: 'مثال: "300"',
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'الموقع',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.body.copyWith(
                          color: AppColor.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'المدينة',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.body,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    InlineDropdownField(
                      hintText: 'اختر المدينة',
                      value: controller.form.cityId,
                      items: controller.cities,
                      onChanged: controller.setCity,
                    ),
                    SizedBox(height: 28.h),
                    SizedBox(
                      width: double.infinity,
                      height: 56.h,
                      child: ElevatedButton(
                        onPressed: controller.isSubmitting ? null : _handleSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.orange900,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                        ),
                        child: controller.isSubmitting
                            ? SizedBox(
                                width: 20.w,
                                height: 20.h,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColor.white,
                                ),
                              )
                            : Text(
                                'إضافة المنتج',
                                style: AppTextStyles.body.copyWith(
                                  color: AppColor.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
