import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../model/order_vm.dart';
import 'offer_card.dart';

class OrderCard extends StatelessWidget {
  final OrderVM order;
  final bool isOffersExpanded;
  final VoidCallback? onDetails;
  final VoidCallback? onOpenDashboard;
  final VoidCallback? onViewDescription;
  final VoidCallback? onToggleOffers;
  final VoidCallback? onOfferAccept;
  final VoidCallback? onOfferReject;
  final VoidCallback? onRate;

  const OrderCard({
    super.key,
    required this.order,
    this.isOffersExpanded = false,
    this.onDetails,
    this.onOpenDashboard,
    this.onViewDescription,
    this.onToggleOffers,
    this.onOfferAccept,
    this.onOfferReject,
    this.onRate,
  });

  Color _chipColor() {
    switch (order.status) {
      case OrderStatus.active:
        return AppColor.orange900;
      case OrderStatus.pending:
        return const Color(0xFFE4A853);
      case OrderStatus.completed:
        return Colors.green;
    }
  }

  String _chipLabel() {
    switch (order.status) {
      case OrderStatus.active:
        return 'نشط';
      case OrderStatus.pending:
        return 'بانتظار';
      case OrderStatus.completed:
        return 'مكتمل';
    }
  }

  Color _iconContainerColor() {
    switch (order.status) {
      case OrderStatus.active:
        return const Color(0x19AF5500);
      case OrderStatus.pending:
        return const Color(0x19E4A853);
      case OrderStatus.completed:
        return Colors.green.withValues(alpha: 0.1);
    }
  }

  Color _iconColor() {
    switch (order.status) {
      case OrderStatus.active:
        return AppColor.orange900;
      case OrderStatus.pending:
        return const Color(0xFFE4A853);
      case OrderStatus.completed:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isActive = order.status == OrderStatus.active;
    final bool isPending = order.status == OrderStatus.pending;
    final bool isCompleted = order.status == OrderStatus.completed;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: ShapeDecoration(
        color: AppColor.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 0.53,
            color: Color(0xFFF2F4F6),
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        shadows: [
          BoxShadow(
            color: const Color(0x19000000),
            blurRadius: 2,
            offset: Offset(0, 1.h),
            spreadRadius: -1,
          ),
          BoxShadow(
            color: const Color(0x19000000),
            blurRadius: 3,
            offset: Offset(0, 1.h),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: ShapeDecoration(
                        color: _iconContainerColor(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        isCompleted ? Icons.home_outlined : Icons.apartment_outlined,
                        size: 16.r,
                        color: _iconColor(),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Flexible(
                      child: Text(
                        order.title,
                        style: AppTextStyles.body.copyWith(
                          fontSize: 16.sp,
                          color: const Color(0xFF111827),
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _chipColor(),
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Text(
                  _chipLabel(),
                  style: AppTextStyles.caption12.copyWith(
                    color: AppColor.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _InfoRow(
            icon: Icons.calendar_today_outlined,
            label: '${order.dateLabel}: ${order.dateValue}',
          ),
          SizedBox(height: 6.h),
          _InfoRow(
            icon: Icons.person_outline,
            label: order.personValue,
          ),
          SizedBox(height: 6.h),
          _InfoRow(
            icon: Icons.account_balance_wallet_outlined,
            label: order.price,
            labelStyle: AppTextStyles.body.copyWith(
              color: AppColor.orange900,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 6.h),
          _InfoRow(
            icon: Icons.description_outlined,
            label: 'رقم الطلب: ${order.orderNumber}',
            labelStyle: AppTextStyles.body.copyWith(
              color: const Color(0xFF697282),
              fontSize: 14.sp,
            ),
          ),
          if (isActive) ...[
            SizedBox(height: 12.h),
            Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${order.progressPercent.toInt()}%',
                  style: AppTextStyles.body.copyWith(
                    color: AppColor.orange900,
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  'نسبة الإنجاز',
                  style: AppTextStyles.body.copyWith(
                    color: const Color(0xFF495565),
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(100.r),
              child: LinearProgressIndicator(
                value: (order.progressPercent / 100).clamp(0.0, 1.0),
                backgroundColor: const Color(0xFFE5E7EB),
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF030213)),
                minHeight: 8.h,
              ),
            ),
          ],
          SizedBox(height: 16.h),
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isActive) ...[
                _FilledButton(label: 'لوحة المتابعة', onPressed: onOpenDashboard ?? () {}),
                _OutlinedButton(label: 'عرض التفاصيل', onPressed: onDetails ?? () {}),
              ] else if (isPending) ...[
                _FilledButton(label: 'العروض المقدمة', onPressed: onToggleOffers ?? () {}),
                _OutlinedButton(label: 'عرض الوصف', onPressed: onViewDescription ?? () {}),
              ] else if (isCompleted) ...[
                _FilledButton(label: 'تقييم', onPressed: onRate ?? () {}),
                _OutlinedButton(label: 'عرض التفاصيل', onPressed: onDetails ?? () {}),
              ],
            ],
          ),
          if (isPending && isOffersExpanded) ...[
            if (order.offers.isEmpty)
              Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: Text(
                  'لم تظهر عروض بعد',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body.copyWith(
                    color: AppColor.grey500,
                    fontSize: 14.sp,
                  ),
                ),
              )
            else
              for (final offer in order.offers)
                OfferCard(
                  offer: offer,
                  onAccept: onOfferAccept,
                  onReject: onOfferReject,
                ),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextStyle? labelStyle;

  const _InfoRow({
    required this.icon,
    required this.label,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Icon(icon, size: 16.r, color: AppColor.grey500),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            label,
            style: labelStyle ?? AppTextStyles.body.copyWith(
              color: const Color(0xFF495565),
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _OutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _OutlinedButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColor.orange900,
        side: const BorderSide(width: 0.53, color: AppColor.orange900),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      ),
      child: Text(
        label,
        style: AppTextStyles.body.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColor.orange900,
        ),
      ),
    );
  }
}

class _FilledButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _FilledButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: AppColor.orange900,
        foregroundColor: AppColor.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      ),
      child: Text(
        label,
        style: AppTextStyles.body.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColor.white,
        ),
      ),
    );
  }
}
