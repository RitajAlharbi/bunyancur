import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/routing/routes.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildAppBar(),
                SizedBox(height: 24.h),
                _buildProfileCard(),
                SizedBox(height: 24.h),
                _buildSectionTitle('الحساب'),
                SizedBox(height: 12.h),
                _buildAccountCard(),
                SizedBox(height: 24.h),
                _buildSectionTitle('المظهر'),
                SizedBox(height: 12.h),
                _buildAppearanceCard(),
                SizedBox(height: 24.h),
                _buildSectionTitle('الدعم'),
                SizedBox(height: 12.h),
                _buildSupportCard(),
                SizedBox(height: 24.h),
                _buildBasicInfoSection(),
                SizedBox(height: 24.h),
                _buildLogoutButton(),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.orange900, size: 24.sp),
          onPressed: () => Navigator.maybePop(context),
        ),
        Expanded(
          child: Text(
            'إعدادات الملف الشخصي',
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFAF5500),
            ),
          ),
        ),
        SizedBox(width: 40.w),
      ],
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColor.lightBeige,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          CircleAvatar(
            radius: 32.r,
            backgroundColor: AppColor.grey200,
            child: Icon(
              Icons.person_outline,
              size: 36.sp,
              color: AppColor.grey500,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'صالح محمد',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.cairo(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.orange900,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'saleh.mohammed@example.com',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.cairo(
                      fontSize: 14.sp,
                      color: AppColor.grey600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      textAlign: TextAlign.right,
      style: GoogleFonts.cairo(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF3A3A3A),
      ),
    );
  }

  Widget _buildAccountCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: _SettingTile(
        icon: Icons.credit_card_outlined,
        iconBgColor: Colors.green.withOpacity(0.2),
        iconColor: Colors.green.shade700,
        title: 'المدفوعات',
        trailing: Icon(Icons.arrow_forward_ios, size: 16.sp, color: AppColor.grey400),
        onTap: () {},
      ),
    );
  }

  Widget _buildAppearanceCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _SettingTile(
            icon: Icons.notifications_outlined,
            iconBgColor: AppColor.orange900.withOpacity(0.15),
            iconColor: AppColor.orange900,
            title: 'الإشعارات',
            trailing: Switch(
              value: _notificationsEnabled,
              onChanged: (value) => setState(() => _notificationsEnabled = value),
              activeTrackColor: AppColor.orange900.withOpacity(0.3),
              activeThumbColor: AppColor.orange900,
            ),
          ),
          Divider(height: 1.h, color: AppColor.grey200, indent: 16.w, endIndent: 16.w),
          _SettingTile(
            icon: Icons.language,
            iconBgColor: Colors.purple.withOpacity(0.15),
            iconColor: Colors.purple.shade700,
            title: 'اللغة',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              textDirection: TextDirection.rtl,
              children: [
                Icon(Icons.arrow_forward_ios, size: 16.sp, color: AppColor.grey400),
                SizedBox(width: 8.w),
                Text(
                  'العربية',
                  style: GoogleFonts.cairo(
                    fontSize: 14.sp,
                    color: AppColor.grey600,
                  ),
                ),
              ],
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSupportCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _SettingTile(
            icon: Icons.help_outline,
            iconBgColor: Colors.blue.withOpacity(0.15),
            iconColor: Colors.blue.shade700,
            title: 'مركز المساعدة',
            trailing: Icon(Icons.arrow_forward_ios, size: 16.sp, color: AppColor.grey400),
            onTap: () {},
          ),
          Divider(height: 1.h, color: AppColor.grey200, indent: 16.w, endIndent: 16.w),
          _SettingTile(
            icon: Icons.flag_outlined,
            iconBgColor: Colors.pink.withOpacity(0.15),
            iconColor: Colors.pink.shade700,
            title: 'البلاغات',
            trailing: Icon(Icons.arrow_forward_ios, size: 16.sp, color: AppColor.grey400),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: TextDirection.rtl,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'البيانات الأساسية',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.cairo(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF3A3A3A),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColor.lightBeige,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'تعديل',
                  style: GoogleFonts.cairo(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColor.orange900,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildDataField(
                icon: Icons.phone_outlined,
                iconBgColor: Colors.blue.withOpacity(0.15),
                iconColor: Colors.blue.shade700,
                label: 'رقم الجوال',
                value: '+966 50 123 4567',
              ),
              Divider(height: 1.h, color: AppColor.grey200, indent: 16.w, endIndent: 16.w),
              _buildDataField(
                icon: Icons.email_outlined,
                iconBgColor: AppColor.orange900.withOpacity(0.15),
                iconColor: AppColor.orange900,
                label: 'البريد الإلكتروني',
                value: 'saleh.mohammed@example.com',
              ),
              Divider(height: 1.h, color: AppColor.grey200, indent: 16.w, endIndent: 16.w),
              _buildDataField(
                icon: Icons.location_on_outlined,
                iconBgColor: Colors.purple.withOpacity(0.15),
                iconColor: Colors.purple.shade700,
                label: 'المدينة',
                value: 'الخرج',
              ),
              Divider(height: 1.h, color: AppColor.grey200, indent: 16.w, endIndent: 16.w),
              _buildDataField(
                icon: Icons.home_outlined,
                iconBgColor: Colors.green.withOpacity(0.15),
                iconColor: Colors.green.shade700,
                label: 'العنوان',
                value: 'حي النخيل',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDataField({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20.sp, color: iconColor),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  label,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.cairo(
                    fontSize: 12.sp,
                    color: AppColor.grey600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.cairo(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColor.grey800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      height: 56.h,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.roles,
            (route) => false,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE53935),
          foregroundColor: AppColor.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          side: const BorderSide(color: Color(0xFFC62828), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: [
            Icon(Icons.logout, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              'تسجيل الخروج',
              style: GoogleFonts.cairo(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String title;
  final Widget trailing;
  final VoidCallback? onTap;

  const _SettingTile({
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.title,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20.sp, color: iconColor),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.right,
                style: GoogleFonts.cairo(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.grey800,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            trailing,
          ],
        ),
      ),
    );
  }
}
