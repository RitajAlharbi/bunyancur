import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import 'widgets/auth_primary_button.dart';
import 'widgets/auth_text_field.dart';
import '../controller/auth_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final AuthController controller;
  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    controller = AuthController();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> _handleSendReset() async {
    final email = emailController.text.trim();
    if (email.isEmpty) return;
    await controller.forgotPassword(email: email);
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
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_forward,
                            color: AppColor.orange900,
                            size: 22.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'رجوع',
                            style: GoogleFonts.cairo(
                              color: AppColor.orange900,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              height: 1.43,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 48.h),
                    Text(
                      'نسيت كلمة المرور',
                      style: GoogleFonts.cairo(
                        color: AppColor.darkText,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.20,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'أدخل بريدك الإلكتروني وسنرسل لك رابط إعادة تعيين كلمة المرور',
                      style: GoogleFonts.cairo(
                        color: AppColor.secondaryText,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                      textAlign: TextAlign.right,
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
                          if (controller.state.forgotPasswordSuccess) ...[
                            SizedBox(height: 12.h),
                            Text(
                              'تم إرسال رابط إعادة التعيين إلى بريدك الإلكتروني',
                              style: GoogleFonts.cairo(
                                color: Colors.green,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                height: 1.43,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                          SizedBox(height: 24.h),
                          AuthPrimaryButton(
                            label: 'إرسال رابط إعادة التعيين',
                            onPressed: _handleSendReset,
                            isLoading: controller.state.isLoading,
                          ),
                        ],
                      ),
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
