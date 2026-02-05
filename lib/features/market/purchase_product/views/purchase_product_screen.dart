import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../controllers/purchase_product_controller.dart';
import '../models/purchase_product_model.dart';
import '../widgets/inline_dropdown_field.dart';
import '../widgets/order_summary_card.dart';
import '../widgets/payment_option_tile.dart';
import '../widgets/purchase_product_card.dart';
import '../widgets/purchase_text_field.dart';

class PurchaseProductScreen extends StatefulWidget {
  final PurchaseProductModel product;

  const PurchaseProductScreen({super.key, required this.product});

  @override
  State<PurchaseProductScreen> createState() => _PurchaseProductScreenState();
}

class _PurchaseProductScreenState extends State<PurchaseProductScreen> {
  late final PurchaseProductController controller;

  @override
  void initState() {
    super.initState();
    controller = PurchaseProductController(product: widget.product);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
                        const SizedBox(width: 40),
                        Expanded(
                          child: Text(
                            'شراء المنتج',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.title.copyWith(fontSize: 22.sp),
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
                    SizedBox(height: 12.h),
                    PurchaseProductCard(product: controller.product),
                    SizedBox(height: 16.h),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        'أدخل تفاصيل الطلب لإتمام عملية الشراء',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.body.copyWith(
                          color: AppColor.grey600,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        'الكمية المطلوبة',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.body.copyWith(
                          color: AppColor.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    PurchaseTextField(
                      controller: controller.quantityController,
                      hintText: 'أدخل الكمية التي ترغب بشرائها',
                    ),
                    SizedBox(height: 16.h),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        'طريقة الاستلام',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.body.copyWith(
                          color: AppColor.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    InlineDropdownField(
                      hintText: 'اختر طريقة الاستلام',
                      value: controller.selectedDeliveryMethod,
                      items: controller.deliveryMethods,
                      onChanged: controller.selectDeliveryMethod,
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '(اختياري)',
                          textAlign: TextAlign.right,
                          style: AppTextStyles.body.copyWith(
                            color: AppColor.grey400,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'موقع التسليم',
                          textAlign: TextAlign.right,
                          style: AppTextStyles.body.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    PurchaseTextField(
                      controller: controller.deliveryLocationController,
                      hintText: 'المدينة أو الموقع التقريبي',
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '(اختياري)',
                          textAlign: TextAlign.right,
                          style: AppTextStyles.body.copyWith(
                            color: AppColor.grey400,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'ملاحظات إضافية',
                          textAlign: TextAlign.right,
                          style: AppTextStyles.body.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    PurchaseTextField(
                      controller: controller.notesController,
                      hintText: 'هل لديك تعليمات خاصة للبائع؟',
                      maxLines: 3,
                    ),
                    SizedBox(height: 20.h),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        'طريقة الدفع',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.body.copyWith(
                          color: AppColor.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    PaymentOptionTile(
                      label: 'الدفع عند الاستلام',
                      isSelected:
                          controller.selectedPayment == PaymentMethod.cashOnDelivery,
                      isDisabled: false,
                      onTap: () =>
                          controller.selectPayment(PaymentMethod.cashOnDelivery),
                    ),
                    SizedBox(height: 12.h),
                    PaymentOptionTile(
                      label: 'تحويل بنكي',
                      isSelected:
                          controller.selectedPayment == PaymentMethod.bankTransfer,
                      isDisabled: false,
                      onTap: () =>
                          controller.selectPayment(PaymentMethod.bankTransfer),
                    ),
                    SizedBox(height: 12.h),
                    PaymentOptionTile(
                      label: 'محفظة بُنيان',
                      helperText: 'قريبًا',
                      isSelected:
                          controller.selectedPayment == PaymentMethod.bunyanWallet,
                      isDisabled: true,
                      onTap: () {},
                    ),
                    SizedBox(height: 16.h),
                    OrderSummaryCard(
                      basePrice: controller.product.priceLabel,
                      quantityLabel: '×${controller.quantityValue}',
                      totalLabel: controller.totalLabel,
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: double.infinity,
                      height: 56.h,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.orange900,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                        ),
                        child: Text(
                          'تأكيد الشراء',
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
                      child: Text(
                        'سيتم إشعار البائع بطلبك خلال دقائق.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.caption12.copyWith(
                          color: AppColor.grey400,
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
