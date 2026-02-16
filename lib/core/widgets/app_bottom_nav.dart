import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_colors.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  /// ترتيب العرض من اليمين لليسار (RTL): الملف الشخصي ← الرسائل ← السوق ← المشاريع ← الرئيسية
  /// الفهارس: 0=الرئيسية، 1=المشاريع، 2=السوق، 3=الرسائل، 4=الملف الشخصي
  static const _items = [
    ('assets/icons/home.svg', 'الرئيسية'),
    ('assets/icons/order.svg', 'المشاريع'),
    ('assets/icons/market.svg', 'السوق'),
    ('assets/icons/chat.svg', 'الرسائل'),
    ('assets/icons/profile.svg', 'الملف الشخصي'),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        top: false,
        child: Container(
          height: 70.h,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              _items.length,
              (i) {
                final index = _items.length - 1 - i;
                return Expanded(
                  child: _NavItem(
                    iconPath: _items[index].$1,
                    label: _items[index].$2,
                    isActive: currentIndex == index,
                    onTap: () => onTap(index),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.iconPath,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = AppColor.orange900;
    final inactiveColor = AppColor.grey600;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 24.w,
              height: 24.h,
              colorFilter: ColorFilter.mode(
                isActive ? activeColor : inactiveColor,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(height: 4.h),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  color: isActive ? activeColor : inactiveColor,
                  fontFamily: 'Cairo',
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
            if (isActive)
              Container(
                margin: EdgeInsets.only(top: 4.h),
                width: 24.w,
                height: 2.h,
                decoration: BoxDecoration(
                  color: activeColor,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
