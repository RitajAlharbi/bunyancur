import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../controllers/product_review_controller.dart';
import '../models/product_review_vm.dart';
import 'thank_you_dialog.dart';

class ProductReviewScreen extends StatefulWidget {
  final ProductReviewVm product;

  const ProductReviewScreen({super.key, required this.product});

  @override
  State<ProductReviewScreen> createState() => _ProductReviewScreenState();
}

class _ProductReviewScreenState extends State<ProductReviewScreen> {
  late final ProductReviewController controller;

  @override
  void initState() {
    super.initState();
    controller = ProductReviewController(initialProduct: widget.product);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _submitReview() async {
    final error = controller.validate();
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: AppColor.orange900,
        ),
      );
      return;
    }

    final success = await controller.submitReview();
    if (!mounted) return;
    if (!success) {
      final message = controller.errorMessage ?? 'تعذر إرسال التقييم حالياً';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppColor.orange900,
        ),
      );
      return;
    }

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => ThankYouDialog(
        onConfirm: () {
          Navigator.pop(dialogContext);
          if (mounted) {
            Navigator.pop(context);
          }
        },
      ),
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
                padding: EdgeInsetsDirectional.fromSTEB(16.w, 12.h, 16.w, 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildHeader(),
                    SizedBox(height: 14.h),
                    _ProductSummaryCard(controller: controller),
                    SizedBox(height: 16.h),
                    _RatingSectionCard(controller: controller),
                    SizedBox(height: 14.h),
                    _CommentSectionCard(controller: controller),
                    SizedBox(height: 14.h),
                    _UploadSectionCard(controller: controller),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: double.infinity,
                      height: 56.h,
                      child: ElevatedButton(
                        onPressed: controller.isSubmitting ? null : _submitReview,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.orange900,
                          disabledBackgroundColor: AppColor.orange900.withValues(alpha: 0.5),
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
                                'ارسال التقييم',
                                style: AppTextStyles.body.copyWith(
                                  color: AppColor.white,
                                  fontWeight: FontWeight.w700,
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

  Widget _buildHeader() {
    return Row(
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
            'تقييم المنتج',
            textAlign: TextAlign.center,
            style: AppTextStyles.title.copyWith(fontSize: 22.sp),
          ),
        ),
        const SizedBox(width: 40),
      ],
    );
  }
}

class _ProductSummaryCard extends StatelessWidget {
  final ProductReviewController controller;

  const _ProductSummaryCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    final product = controller.product;
    final imagePath = product.imagePath?.trim() ?? '';
    final productName = product.productName?.trim().isNotEmpty == true
        ? product.productName!.trim()
        : 'غير متوفر';
    final sellerName = product.sellerName?.trim().isNotEmpty == true
        ? product.sellerName!.trim()
        : 'غير متوفر';
    final priceLabel = product.priceLabel?.trim().isNotEmpty == true
        ? product.priceLabel!.trim()
        : 'غير متوفر';
    final orderNumber = product.orderNumber?.trim().isNotEmpty == true
        ? product.orderNumber!.trim()
        : 'غير متوفر';
    final imageProvider = imagePath.isNotEmpty
        ? (imagePath.startsWith('http')
            ? NetworkImage(imagePath) as ImageProvider
            : AssetImage(imagePath))
        : const AssetImage('assets/images/ImageWithFallback.png');
    return Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 14.h),
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
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
              color: AppColor.grey100,
              borderRadius: BorderRadius.circular(12.r),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    productName,
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.body.copyWith(
                      color: AppColor.slate700,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'البائع: $sellerName',
                    textAlign: TextAlign.right,
                    style: AppTextStyles.caption12.copyWith(
                      color: AppColor.grey500,
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    priceLabel,
                    textAlign: TextAlign.right,
                    style: AppTextStyles.price.copyWith(
                      color: AppColor.orange900,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'رقم الطلب: $orderNumber',
                    textAlign: TextAlign.right,
                    style: AppTextStyles.caption12.copyWith(
                      color: AppColor.grey500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingSectionCard extends StatelessWidget {
  final ProductReviewController controller;

  const _RatingSectionCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.fromSTEB(16.w, 18.h, 16.w, 18.h),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.grey200, width: 0.53),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              'كيف كانت تجربتك مع المنتج؟',
              textAlign: TextAlign.right,
              style: AppTextStyles.body.copyWith(
                color: AppColor.slate700,
                fontSize: 32.sp / 2,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final selected = controller.rating >= index + 1;
              return IconButton(
                onPressed: () => controller.setRating(index + 1),
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                icon: Icon(
                  selected ? Icons.star_rounded : Icons.star_border_rounded,
                  size: 40.r,
                  color: selected ? AppColor.orange900 : AppColor.grey200,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _CommentSectionCard extends StatelessWidget {
  final ProductReviewController controller;

  const _CommentSectionCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.fromSTEB(16.w, 18.h, 16.w, 12.h),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.grey200, width: 0.53),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              'أخبرنا المزيد عن تجربتك (اختياري)',
              textAlign: TextAlign.right,
              style: AppTextStyles.body.copyWith(
                color: AppColor.slate700,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          TextField(
            controller: controller.commentController,
            maxLines: 5,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            inputFormatters: [
              LengthLimitingTextInputFormatter(ProductReviewController.maxCommentChars),
            ],
            decoration: InputDecoration(
              hintText: 'شارك تجربتك مع المنتج ليستفيد الآخرون من رأيك...',
              hintStyle: AppTextStyles.body.copyWith(color: AppColor.grey400),
              filled: true,
              fillColor: AppColor.white,
              contentPadding: EdgeInsetsDirectional.fromSTEB(14.w, 14.h, 14.w, 14.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColor.grey200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColor.grey200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColor.orange900),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              controller.counterText,
              style: AppTextStyles.caption12.copyWith(color: AppColor.grey400),
            ),
          ),
        ],
      ),
    );
  }
}

class _UploadSectionCard extends StatelessWidget {
  final ProductReviewController controller;

  const _UploadSectionCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.fromSTEB(16.w, 18.h, 16.w, 14.h),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.grey200, width: 0.53),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              'أضف صور للمنتج (اختياري)',
              textAlign: TextAlign.right,
              style: AppTextStyles.body.copyWith(
                color: AppColor.slate700,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Wrap(
            alignment: WrapAlignment.end,
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              ...List.generate(controller.images.length, (index) {
                final image = controller.images[index];
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.file(
                        key: ValueKey(image.path),
                        File(image.path),
                        width: 64.w,
                        height: 64.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    PositionedDirectional(
                      top: -6.h,
                      start: -6.w,
                      child: GestureDetector(
                        onTap: () => controller.removeImage(index),
                        child: Container(
                          width: 18.w,
                          height: 18.h,
                          decoration: const BoxDecoration(
                            color: AppColor.orange900,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.close,
                            size: 12.r,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
              if (controller.images.length < ProductReviewController.maxImages)
                GestureDetector(
                  onTap: controller.pickImages,
                  child: Container(
                    width: 64.w,
                    height: 72.h,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColor.grey200),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          size: 20.r,
                          color: AppColor.grey400,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'إضافة',
                          style: AppTextStyles.caption12.copyWith(
                            color: AppColor.grey400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: double.infinity,
            child: Text(
              'يمكنك إضافة حتى 4 صور',
              textAlign: TextAlign.right,
              style: AppTextStyles.caption12.copyWith(color: AppColor.grey400),
            ),
          ),
        ],
      ),
    );
  }
}
