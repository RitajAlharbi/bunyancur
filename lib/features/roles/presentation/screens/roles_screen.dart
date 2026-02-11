import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/routing/routes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../controllers/roles_controller.dart';
import '../../models/role_type.dart';

class RolesScreen extends StatefulWidget {
  final bool returnRoleOnSelect;

  const RolesScreen({super.key, this.returnRoleOnSelect = false});

  @override
  State<RolesScreen> createState() => _RolesScreenState();
}

class _RolesScreenState extends State<RolesScreen> {
  late final RolesController controller;

  @override
  void initState() {
    super.initState();
    controller = RolesController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _handleRole(RoleType role) {
    if (widget.returnRoleOnSelect) {
      Navigator.pop(context, role.name);
    } else {
      controller.onRoleSelected(role);
      Navigator.pushReplacementNamed(
      context,
      Routes.loginScreen,
      arguments: role,
    );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColor.gradientStart,
                AppColor.gradientEnd,
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/icons/Group 22.svg',
                    width: 160.w,
                    height: 160.h,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 24.h),
                  _RoleCard(
                    title: 'العميل',
                    subtitle: 'ابحث عن مقاولين ومصممين لمشروعك',
                    iconPath: 'assets/icons/Icon-2.svg',
                    onTap: () => _handleRole(RoleType.client),
                  ),
                  SizedBox(height: 16.h),
                  _RoleCard(
                    title: 'المقاول',
                    subtitle: 'إدارة المشاريع والعروض والفرص',
                    iconPath: 'assets/icons/Icon-1.svg',
                    onTap: () => _handleRole(RoleType.contractor),
                  ),
                  SizedBox(height: 16.h),
                  _RoleCard(
                    title: 'المصمم',
                    subtitle: 'عرض أعمالك واستقبال طلبات التصميم',
                    iconPath: 'assets/icons/Icon.svg',
                    onTap: () => _handleRole(RoleType.designer),
                  ),
                  SizedBox(height: 32.h),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.adminLogin,
                      );
                    },
                    child: Text(
                      'تسجيل دخول الادمن (مؤقت)',
                      style: AppTextStyles.body.copyWith(
                        color: AppColor.orange900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String iconPath;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Container(
              width: 48.w,
              height: 48.h,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: AppColor.grey100,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                iconPath,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: AppTextStyles.sectionTitle,
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    subtitle,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: AppTextStyles.body.copyWith(color: AppColor.grey600),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            SvgPicture.asset(
              'assets/icons/Icon-3.svg',
              width: 20.w,
              height: 20.h,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
