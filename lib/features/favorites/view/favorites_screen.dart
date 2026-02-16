import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../controller/favorites_controller.dart';
import '../widgets/favorite_account_card.dart';
import '../widgets/favorite_product_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoritesController(),
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: const _SegmentSwitch(),
                ),
                SizedBox(height: 24.h),
                Expanded(
                  child: Consumer<FavoritesController>(
                    builder: (context, controller, _) {
                      if (controller.segmentIndex == 0) {
                        final list = controller.products;
                        if (list.isEmpty) {
                          return Center(
                            child: Text(
                              'لا توجد منتجات في المفضلة',
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
                          separatorBuilder: (_, __) => SizedBox(height: 20.h),
                          itemBuilder: (context, index) {
                            final item = list[index];
                            return FavoriteProductCard(
                              item: item,
                              onRemove: () => controller.removeProduct(item.id),
                            );
                          },
                        );
                      } else {
                        final list = controller.accounts;
                        if (list.isEmpty) {
                          return Center(
                            child: Text(
                              'لا توجد حسابات في المفضلة',
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
                          separatorBuilder: (_, __) => SizedBox(height: 20.h),
                          itemBuilder: (context, index) {
                            final item = list[index];
                            return FavoriteAccountCard(
                              item: item,
                              onRemove: () => controller.removeAccount(item.id),
                            );
                          },
                        );
                      }
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
              Icons.arrow_back,
              color: AppColor.orange900,
              size: 24.sp,
            ),
          ),
          Expanded(
            child: Text(
              'المفضلة',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
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

class _SegmentSwitch extends StatelessWidget {
  const _SegmentSwitch();

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesController>(
      builder: (context, controller, _) {
        final active = controller.segmentIndex;
        return Container(
          height: 48.h,
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppColor.grey200,
            borderRadius: BorderRadius.circular(26.r),
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
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.setSegment(0),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: active == 0 ? AppColor.white : AppColor.grey200,
                      borderRadius: BorderRadius.circular(22.r),
                      border: active == 0 ? Border.all(color: AppColor.grey400, width: 1) : null,
                      boxShadow: active == 0
                          ? [
                              BoxShadow(
                                color: AppColor.black.withValues(alpha: 0.05),
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              ),
                            ]
                          : [],
                    ),
                    child: Text(
                      'المنتجات',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: active == 0 ? FontWeight.w700 : FontWeight.w600,
                        color: active == 0 ? AppColor.black : AppColor.grey700,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.setSegment(1),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: active == 1 ? AppColor.white : AppColor.grey200,
                      borderRadius: BorderRadius.circular(22.r),
                      border: active == 1 ? Border.all(color: AppColor.grey400, width: 1) : null,
                      boxShadow: active == 1
                          ? [
                              BoxShadow(
                                color: AppColor.black.withValues(alpha: 0.05),
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              ),
                            ]
                          : [],
                    ),
                    child: Text(
                      'الحسابات',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: active == 1 ? FontWeight.w700 : FontWeight.w600,
                        color: active == 1 ? AppColor.black : AppColor.grey700,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
