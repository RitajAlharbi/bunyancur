import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routing/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../features/create_project/widgets/create_project_primary_button.dart';
import '../../../features/market/add_product/widgets/app_text_field.dart';
import '../controllers/admin_login_controller.dart';

/// Admin login screen. Uses mock credentials (admin / admin).
class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  late final AdminLoginController controller;

  @override
  void initState() {
    super.initState();
    controller = AdminLoginController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    final destination = await controller.submit();
    if (!mounted) return;
    if (destination == AdminLoginDestination.adminHome) {
      Navigator.pushReplacementNamed(context, Routes.adminHome);
    } else {
      Navigator.pushReplacementNamed(context, Routes.homeScreen);
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
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'تسجيل دخول الأدمن',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.title.copyWith(
                            color: AppColor.black,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'ادخل بيانات الدخول للمتابعة',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.caption12,
                        ),
                        SizedBox(height: 24.h),
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
                              Text(
                                'اسم المستخدم',
                                textAlign: TextAlign.right,
                                style: AppTextStyles.body,
                              ),
                              SizedBox(height: 8.h),
                              AppTextField(
                                controller: controller.usernameController,
                                hintText: 'admin',
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: AppColor.grey500,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                'كلمة المرور',
                                textAlign: TextAlign.right,
                                style: AppTextStyles.body,
                              ),
                              SizedBox(height: 8.h),
                              AppTextField(
                                controller: controller.passwordController,
                                hintText: '••••••••',
                                obscureText: true,
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: AppColor.grey500,
                                ),
                              ),
                              SizedBox(height: 24.h),
                              CreateProjectPrimaryButton(
                                label: controller.isSubmitting
                                    ? 'جاري الدخول...'
                                    : 'تسجيل الدخول',
                                onPressed: controller.isSubmitting
                                    ? null
                                    : (controller.isFormValid
                                        ? _handleSubmit
                                        : null),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),
                        TextButton(
                          onPressed: () =>
                              Navigator.pushReplacementNamed(
                                  context, Routes.roles),
                          child: Text(
                            'العودة لاختيار الدور',
                            style: AppTextStyles.caption12.copyWith(
                              color: AppColor.orange900,
                            ),
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
