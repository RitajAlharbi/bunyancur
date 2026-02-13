import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../controllers/order_success_controller.dart';
import '../models/order_success_vm.dart';

class OrderSuccessScreen extends StatefulWidget {
  final OrderSuccessVm? order;

  const OrderSuccessScreen({super.key, this.order});

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  late final OrderSuccessController controller;
  bool _isConfirmingDelivery = false;

  @override
  void initState() {
    super.initState();
    controller = OrderSuccessController(initialOrder: widget.order);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final order = controller.order;
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
                SizedBox(height: 20.h),
                _OrderNumberCard(orderNumber: order.orderNumber),
                SizedBox(height: 16.h),
                _OrderSummaryCard(controller: controller),
                SizedBox(height: 24.h),
                _ActionButton(
                  text: 'مراسلة البائع',
                  iconAsset: 'assets/icons/Iconmasg.svg',
                  textColor: AppColor.orange900,
                  borderColor: AppColor.orange900,
                  onTap: () => controller.onMessageSeller(context),
                ),
                SizedBox(height: 10.h),
                _ActionButton(
                  text: 'تقييم المنتج',
                  iconAsset: 'assets/icons/Iconstart.svg',
                  textColor: AppColor.successBorder,
                  borderColor: AppColor.successBorder,
                  onTap: _onConfirmDeliveryTap,
                ),
                SizedBox(height: 10.h),
                _ActionButton(
                  text: 'العودة للرئيسية',
                  textColor: AppColor.white,
                  fillColor: AppColor.orange900,
                  onTap: () => controller.onBackToHome(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onConfirmDeliveryTap() async {
    if (_isConfirmingDelivery) return;
    setState(() => _isConfirmingDelivery = true);
    try {
      final reviewVm = await controller.confirmDeliveryForReview();
      if (!mounted) return;
      Navigator.pushNamed(
        context,
        Routes.productReview,
        arguments: reviewVm,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_toReadableError(e)),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isConfirmingDelivery = false);
      }
    }
  }

  String _toReadableError(Object error) {
    final message = error.toString();
    if (message.startsWith('Exception: ')) {
      return message.substring('Exception: '.length);
    }
    if (message.startsWith('Invalid argument(s): ')) {
      return message.substring('Invalid argument(s): '.length);
    }
    return message;
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
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
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
          'تم تأكيد طلبك بنجاح!',
          textAlign: TextAlign.center,
          style: AppTextStyles.body.copyWith(
            color: AppColor.darkText,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          'شكرًا لك! تم استلام طلبك وسيتم معالجته قريبًا',
          textAlign: TextAlign.center,
          style: AppTextStyles.body.copyWith(
            color: AppColor.secondaryText,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}

class _OrderNumberCard extends StatelessWidget {
  final String orderNumber;

  const _OrderNumberCard({required this.orderNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(20.w, 20.h, 20.w, 20.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            AppColor.orange900.withValues(alpha: 0.08),
            AppColor.white.withValues(alpha: 0.0),
          ],
        ),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'رقم الطلب',
                    textAlign: TextAlign.right,
                    style: AppTextStyles.body.copyWith(
                      color: AppColor.slate500,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    orderNumber,
                    textAlign: TextAlign.right,
                    style: AppTextStyles.body.copyWith(
                      color: AppColor.orange900,
                      fontSize: 16.sp,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: AppColor.orange900.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/Iconfile.svg',
                width: 24.w,
                height: 24.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderSummaryCard extends StatelessWidget {
  final OrderSuccessController controller;

  const _OrderSummaryCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    final order = controller.order;
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
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    'ملخص الطلب',
                    textAlign: TextAlign.right,
                    style: AppTextStyles.body.copyWith(
                      color: AppColor.darkText,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.inventory_2_outlined,
                size: 20.r,
                color: AppColor.orange900,
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        order.productName,
                        textAlign: TextAlign.right,
                        style: AppTextStyles.body.copyWith(
                          color: AppColor.slate700,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'الكمية: ${order.quantity}',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.caption12.copyWith(
                          color: AppColor.slate500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                order.price,
                textAlign: TextAlign.left,
                style: AppTextStyles.body.copyWith(
                  color: AppColor.orange900,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(color: AppColor.black.withValues(alpha: 0.1), height: 1.h),
          SizedBox(height: 14.h),
          _DeliveryInfoRow(
            icon: Icons.local_shipping_outlined,
            label: 'طريقة الاستلام',
            value: order.deliveryMethod,
          ),
          SizedBox(height: 10.h),
          _DeliveryInfoRow(
            icon: Icons.location_on_outlined,
            label: 'موقع التسليم',
            value: order.location,
          ),
          SizedBox(height: 10.h),
          _DeliveryInfoRow(
            icon: Icons.access_time_outlined,
            label: 'الوقت المتوقع للتسليم',
            value: order.eta,
          ),
          SizedBox(height: 16.h),
          Divider(color: AppColor.black.withValues(alpha: 0.1), height: 1.h),
          SizedBox(height: 14.h),
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الإجمالي',
                textAlign: TextAlign.right,
                style: AppTextStyles.body.copyWith(
                  color: AppColor.slate700,
                  fontSize: 16.sp,
                ),
              ),
              Text(
                order.total,
                textAlign: TextAlign.left,
                style: AppTextStyles.price.copyWith(
                  color: AppColor.orange900,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DeliveryInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DeliveryInfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  label,
                  textAlign: TextAlign.right,
                  style: AppTextStyles.caption12.copyWith(
                    color: AppColor.slate500,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              SizedBox(
                width: double.infinity,
                child: Text(
                  value,
                  textAlign: TextAlign.right,
                  style: AppTextStyles.body.copyWith(
                    color: AppColor.slate700,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        Container(
          width: 32.w,
          height: 32.h,
          decoration: BoxDecoration(
            color: AppColor.grey100,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, size: 16.r, color: AppColor.grey600),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final String? iconAsset;
  final Color? borderColor;
  final Color textColor;
  final Color? fillColor;

  const _ActionButton({
    required this.text,
    required this.onTap,
    required this.textColor,
    this.iconAsset,
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
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconAsset != null) ...[
              SvgPicture.asset(
                iconAsset!,
                width: 20.w,
                height: 20.h,
                colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
              ),
              SizedBox(width: 8.w),
            ],
            Text(
              text,
              textAlign: TextAlign.center,
              style: AppTextStyles.body.copyWith(
                color: textColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
