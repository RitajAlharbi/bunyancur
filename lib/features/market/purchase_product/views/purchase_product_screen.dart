import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/routing/routes.dart';
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
                            'شراء المنتج',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.title.copyWith(fontSize: 22.sp),
                          ),
                        ),
                        const SizedBox(width: 40),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    PurchaseProductCard(product: controller.product),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'أدخل تفاصيل الطلب لإتمام عملية الشراء',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.body.copyWith(
                          color: AppColor.grey600,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    SizedBox(
                      width: double.infinity,
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
                    SizedBox(
                      width: double.infinity,
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
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'موقع التسليم',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.body.copyWith(
                          color: AppColor.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    PurchaseTextField(
                      controller: controller.deliveryLocationController,
                      hintText: 'المدينة أو الموقع التقريبي',
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: double.infinity,
                      child: RichText(
                        textAlign: TextAlign.right,
                        text: TextSpan(
                          style: AppTextStyles.body.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            const TextSpan(text: 'ملاحظات إضافية '),
                            TextSpan(
                              text: '(اختياري)',
                              style: AppTextStyles.body.copyWith(
                                color: AppColor.grey400,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    PurchaseTextField(
                      controller: controller.notesController,
                      hintText: 'هل لديك تعليمات خاصة للبائع؟',
                      maxLines: 3,
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: double.infinity,
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
                        onPressed: controller.isSubmitting
                            ? null
                            : controller.canConfirmPurchase
                            ? () async {
                                final error = controller.validateBeforePurchase();
                                if (error != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(error),
                                      backgroundColor: AppColor.orange900,
                                    ),
                                  );
                                  return;
                                }
                                final orderData = await controller.submitOrder();
                                if (!context.mounted) return;
                                if (orderData == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('تعذر إنشاء الطلب حالياً'),
                                      backgroundColor: AppColor.orange900,
                                    ),
                                  );
                                  return;
                                }
                                Navigator.pushNamed(
                                  context,
                                  Routes.orderSuccess,
                                  arguments: orderData,
                                );
                              }
                            : () {
                                final error = controller.validateBeforePurchase();
                                if (error == null) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(error),
                                    backgroundColor: AppColor.orange900,
                                  ),
                                );
                              },
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
