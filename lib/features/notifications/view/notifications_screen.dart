import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../controller/notifications_controller.dart';
import '../widgets/notification_tile.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotificationsController(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppColor.white,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Header(),
                SizedBox(height: 24.h),
                Expanded(
                  child: Consumer<NotificationsController>(
                    builder: (context, controller, _) {
                      final list = controller.items;
                      if (list.isEmpty) {
                        return Center(
                          child: Text(
                            'لا توجد إشعارات',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColor.grey600,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        );
                      }
                      return ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                        itemCount: list.length,
                        separatorBuilder: (_, __) => SizedBox(height: 16.h),
                        itemBuilder: (context, index) {
                          return NotificationTile(item: list[index]);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_forward,
              color: AppColor.orange900,
              size: 24.sp,
            ),
          ),
          Expanded(
            child: Text(
              'الإشعارات',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColor.orange900,
                fontFamily: 'Cairo',
              ),
            ),
          ),
          SizedBox(width: 48.w),
        ],
      ),
    );
  }
}
