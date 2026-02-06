import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/routing/routes.dart';
import '../controller/add_product_controller.dart';
import '../widgets/app_text_field.dart';
import '../widgets/attachment_card.dart';
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

  void _handleSubmit() {
    final errorMessage = controller.validateRequiredFields();
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
                padding: EdgeInsetsDirectional.fromSTEB(24.w, 16.h, 24.w, 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(24.r),
                        child: Transform.rotate(
                          angle: 3.14159,
                          child: SvgPicture.asset(
                            'assets/icons/Icon-3.svg',
                            width: 20.w,
                            height: 20.h,
                            colorFilter: const ColorFilter.mode(
                              AppColor.orange900,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'إضافة منتج',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.title,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'أضف صور المنتج ومواصفاته بدقة لعرضه في السوق.',
                        style: AppTextStyles.body,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        'صور المنتج',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.sectionTitle,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    ProductImagePickerCard(
                      imageCount: controller.form.images.length,
                      onTap: () {
                        if (controller.form.images.length >= 3) {
                          _showSnackBar('يمكنك رفع حتى 3 صور للمنتج');
                          return;
                        }
                        controller.addMockImage();
                      },
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
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        'التفاصيل الأساسية',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.sectionTitle,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
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
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
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
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        'الفئة / النوع',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.body,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    InlineDropdownField(
                      hintText: 'اختر الفئة',
                      value: controller.form.categoryId,
                      items: controller.categories,
                      onChanged: controller.setCategory,
                    ),
                    SizedBox(height: 16.h),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
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
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
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
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        'الموقع',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.sectionTitle,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
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
                    SizedBox(height: 24.h),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        'المرفقات (اختياري)',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.sectionTitle,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    AttachmentCard(
                      attachmentName: controller.form.attachment,
                      onTap: controller.toggleAttachment,
                    ),
                    SizedBox(height: 28.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _handleSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.orange900,
                          padding: EdgeInsetsDirectional.symmetric(
                            vertical: 16.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        child: Text(
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
