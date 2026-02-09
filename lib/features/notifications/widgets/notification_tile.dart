import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../model/notification_model.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel item;

  const NotificationTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _IconCircle(iconType: item.iconType),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  item.text,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColor.black,
                    fontFamily: 'Cairo',
                    height: 1.4,
                  ),
                  textAlign: TextAlign.right,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),
                Text(
                  item.timeAgo,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColor.grey600,
                    fontFamily: 'Cairo',
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          if (item.isUnread) ...[
            SizedBox(width: 12.w),
            Container(
              margin: EdgeInsets.only(top: 6.h),
              width: 8.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: AppColor.orange900,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _IconCircle extends StatelessWidget {
  final NotificationIconType iconType;

  const _IconCircle({required this.iconType});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: AppColor.grey100,
        shape: BoxShape.circle,
        border: Border.all(color: AppColor.grey200),
      ),
      child: Icon(
        _icon,
        size: 20.sp,
        color: AppColor.orange900,
      ),
    );
  }

  IconData get _icon {
    switch (iconType) {
      case NotificationIconType.approval:
        return Icons.check_circle_outline;
      case NotificationIconType.payment:
        return Icons.receipt_long_outlined;
      case NotificationIconType.message:
        return Icons.chat_bubble_outline;
      case NotificationIconType.projectNearby:
        return Icons.home_outlined;
      case NotificationIconType.rejection:
        return Icons.close;
    }
  }
}
