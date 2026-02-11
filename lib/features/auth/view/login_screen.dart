import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/routing/routes.dart';
import 'widgets/auth_primary_button.dart';
import 'widgets/auth_text_field.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final AuthController controller;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    controller = AuthController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      controller.clearError();
      return;
    }
    await controller.login(email: email, password: password);
    if (!mounted) return;
    if (controller.state.error == null && controller.state.profile != null) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.clientHome,
        (route) => false,
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
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/Group 22.svg',
                      width: 160.w,
                      height: 160.h,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'أهلاً بك في بُنيان',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(
                        color: AppColor.darkText,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.20,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'سجّل دخولك للمتابعة',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(
                        color: AppColor.secondaryText,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    Container(
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x0C000000),
                            blurRadius: 3,
                            offset: Offset(0, 1.h),
                          ),
                        ],
                        border: Border.all(
                          width: 0.53,
                          color: AppColor.grey200,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AuthTextField(
                            controller: emailController,
                            label: 'البريد الإلكتروني',
                            hintText: 'example@email.com',
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 16.h),
                          AuthTextField(
                            controller: passwordController,
                            label: 'كلمة المرور',
                            hintText: 'أدخل كلمة المرور',
                            prefixIcon: Icons.lock_outline,
                            obscureText: _obscurePassword,
                            onToggleObscure: () {
                              setState(() => _obscurePassword = !_obscurePassword);
                            },
                          ),
                          if (controller.state.error != null) ...[
                            SizedBox(height: 8.h),
                            Text(
                              controller.state.error!,
                              style: GoogleFonts.cairo(
                                color: Colors.red,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400,
                                height: 1.43,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                          SizedBox(height: 8.h),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(Routes.forgotPassword);
                              },
                              child: Text(
                                'نسيت كلمة المرور؟',
                                style: GoogleFonts.cairo(
                                  color: AppColor.orange900,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.43,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 24.h),
                          AuthPrimaryButton(
                            label: 'تسجيل الدخول',
                            onPressed: _handleLogin,
                            isLoading: controller.state.isLoading,
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            'أو تسجيل الدخول باستخدام',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cairo(
                              color: AppColor.secondaryText,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              height: 1.43,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _SocialButton(
                                label: 'Apple',
                                onTap: () {},
                              ),
                              SizedBox(width: 16.w),
                              _SocialButton(
                                label: 'Google',
                                onTap: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ليس لديك حساب؟',
                          style: GoogleFonts.cairo(
                            color: AppColor.secondaryText,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            height: 1.43,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed(
                              Routes.signup,
                            );
                          },
                          child: Text(
                            'إنشاء حساب جديد',
                            style: GoogleFonts.cairo(
                              color: AppColor.orange900,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              height: 1.43,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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

class _SocialButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _SocialButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColor.grey200),
        ),
        child: Text(
          label,
          style: GoogleFonts.cairo(
            color: AppColor.darkText,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            height: 1.43,
          ),
        ),
      ),
    );
  }
}
