import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/message_thread_model.dart';

class ThreadTile extends StatelessWidget {
  final MessageThreadModel thread;
  final VoidCallback onTap;

  const ThreadTile({
    super.key,
    required this.thread,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            _Avatar(
              initial: thread.avatarInitial,
              isOnline: thread.isOnline,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Expanded(
                        child: Text(
                          thread.name,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: AppTextStyles.body.copyWith(
                            color: AppColor.grey700,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        thread.timeLabel,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: AppTextStyles.caption12.copyWith(
                          color: thread.unreadCount > 0
                              ? AppColor.orange900
                              : AppColor.grey500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Expanded(
                        child: Text(
                          thread.lastMessage,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: AppTextStyles.body.copyWith(
                            color: AppColor.grey600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (thread.unreadCount > 0) ...[
                        SizedBox(width: 8.w),
                        Container(
                          width: 22.w,
                          height: 22.h,
                          decoration: const BoxDecoration(
                            color: AppColor.orange900,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              thread.unreadCount.toString(),
                              textAlign: TextAlign.center,
                              style: AppTextStyles.caption10.copyWith(
                                color: AppColor.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String initial;
  final bool isOnline;

  const _Avatar({
    required this.initial,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56.w,
      height: 56.h,
      child: Stack(
        children: [
          Container(
            width: 56.w,
            height: 56.h,
            decoration: const BoxDecoration(
              color: AppColor.orange900,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                initial,
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: AppTextStyles.sectionTitle.copyWith(
                  color: AppColor.white,
                ),
              ),
            ),
          ),
          Positioned(
            right: 4.w,
            bottom: 4.h,
            child: Container(
              width: 14.w,
              height: 14.h,
              decoration: BoxDecoration(
                color: isOnline ? AppColor.orange900 : AppColor.grey400,
                shape: BoxShape.circle,
                border: Border.all(color: AppColor.white, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
