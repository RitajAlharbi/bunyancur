import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/routing/routes.dart';
import '../../../features/create_project/widgets/create_project_primary_button.dart';
import '../../../features/market/add_product/widgets/app_text_field.dart';
import '../../roles/models/role_type.dart';
import '../controllers/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    this.role,
  });

  /// The selected user role (client / contractor / designer).
  ///
  /// This is passed from the roles screen and can be used later for
  /// role‑specific flows. For now it's stored only for future use.
  final RoleType? role;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginController controller;

  @override
  void initState() {
    super.initState();
    controller = LoginController();
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
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Logo
                        SizedBox(height: 12.h),
                        Align(
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            'assets/images/bunyan_logo.svg',
                            width: 120.w,
                            height: 120.h,
                          ),
                        ),
                        SizedBox(height: 24.h),

                        // Title & subtitle
                        Text(
                          'أهلاً بك في بنيان',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.title.copyWith(
                            color: AppColor.black,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'سجل دخولك للمتابعة',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.caption12,
                        ),
                        SizedBox(height: 24.h),

                        // Card with form
                        Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(24.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 18,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Phone field
                              Text(
                                'رقم الجوال',
                                textAlign: TextAlign.right,
                                style: AppTextStyles.body,
                              ),
                              SizedBox(height: 8.h),
                              AppTextField(
                                controller: controller.phoneController,
                                hintText: '05xxxxxxxx',
                                keyboardType: TextInputType.phone,
                                prefixIcon: Icon(
                                  Icons.phone_iphone,
                                  color: AppColor.grey500,
                                ),
                              ),
                              SizedBox(height: 16.h),

                              // Password field
                              Text(
                                'كلمة المرور',
                                textAlign: TextAlign.right,
                                style: AppTextStyles.body,
                              ),
                              SizedBox(height: 8.h),
                              AppTextField(
                                controller: controller.passwordController,
                                hintText: 'أدخل كلمة المرور',
                                obscureText: !controller.isPasswordVisible,
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: AppColor.grey500,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.isPasswordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: AppColor.grey500,
                                  ),
                                  onPressed: controller.togglePasswordVisibility,
                                ),
                              ),
                              SizedBox(height: 12.h),

                              // Forgot password
                              Align(
                                alignment: Alignment.centerLeft,
                                child: TextButton(
                                  onPressed: () {
                                    // TODO: Forgot password flow
                                  },
                                  child: Text(
                                    'نسيت كلمة المرور؟',
                                    style: AppTextStyles.caption12.copyWith(
                                      color: AppColor.orange900,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.h),

                              // Login button
                              CreateProjectPrimaryButton(
                                label: 'تسجيل الدخول',
                                onPressed: controller.isFormValid
                                    ? () {
                                        Navigator.pushReplacementNamed(
                                            context, Routes.homeScreen);
                                      }
                                    : null,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // Social login
                        Column(
                          children: [
                            Text(
                              'أو تسجيل الدخول باستخدام',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.caption12,
                            ),
                            SizedBox(height: 16.h),
                            Row(
                              children: [
                                Expanded(
                                  child: _SocialLoginButton(
                                    label: 'Apple',
                                    icon: Icons.apple,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: _SocialLoginButton(
                                    label: 'Google',
                                    icon: Icons.g_mobiledata,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 24.h),

                        // Register link
                        Center(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 4.w,
                            children: [
                              Text(
                                'ليس لديك حساب؟',
                                style: AppTextStyles.caption12,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // TODO: Navigate to register screen
                                },
                                child: Text(
                                  'إنشاء حساب جديد',
                                  style: AppTextStyles.caption12.copyWith(
                                    color: AppColor.orange900,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialLoginButton extends StatelessWidget {
  final String label;
  final IconData icon;

  const _SocialLoginButton({
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColor.white,
          side: BorderSide(color: AppColor.grey200),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        onPressed: () {
          // UI only for now
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: AppColor.black,
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: AppTextStyles.body.copyWith(
                color: AppColor.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

