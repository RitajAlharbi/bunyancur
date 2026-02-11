import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/routing/routes.dart';
import 'widgets/auth_primary_button.dart';
import 'widgets/auth_text_field.dart';
import '../controller/auth_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final AuthController controller;
  late final TextEditingController fullNameController;
  late final TextEditingController phoneController;
  late final TextEditingController commercialRegisterController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  bool _obscurePassword = true;
  bool _agreedToTerms = false;
  String _roleKey = 'client';
  String? _validationError;

  @override
  void initState() {
    super.initState();
    controller = AuthController();
    fullNameController = TextEditingController();
    phoneController = TextEditingController();
    commercialRegisterController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    commercialRegisterController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String _roleLabel(String roleKey) {
    return switch (roleKey) {
      'client' => 'عميل',
      'contractor' => 'مقاول',
      'designer' => 'مصمم',
      _ => 'عميل',
    };
  }

  String _roleIconPath(String roleKey) {
    return switch (roleKey) {
      'client' => 'assets/icons/Icon-2.svg',
      'contractor' => 'assets/icons/Icon222.svg',
      'designer' => 'assets/icons/Icon22.svg',
      _ => 'assets/icons/Icon-2.svg',
    };
  }

  Color _roleIconBgColor(String roleKey) {
    return switch (roleKey) {
      'client' => AppColor.orange900.withValues(alpha: 0.06),
      'contractor' => const Color(0x100EA5E9),
      'designer' => const Color(0x10F59E0B),
      _ => AppColor.orange900.withValues(alpha: 0.06),
    };
  }

  bool get _isContractorOrDesigner =>
      _roleKey == 'contractor' || _roleKey == 'designer';

  Future<void> _navigateToRolesScreen() async {
    final result = await Navigator.of(context).pushNamed(
      Routes.roles,
      arguments: true,
    );
    if (!mounted || result == null) return;
    setState(() => _roleKey = result as String);
  }

  Future<void> _handleSignUp() async {
    final fullName = fullNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final phone = phoneController.text.trim();
    final commercialRegister = commercialRegisterController.text.trim();
    controller.clearError();
    setState(() => _validationError = null);
    if (fullName.isEmpty || email.isEmpty || password.isEmpty) return;
    if (_isContractorOrDesigner && commercialRegister.isEmpty) {
      setState(() => _validationError = 'رقم السجل التجاري مطلوب');
      return;
    }
    if (!_agreedToTerms) return;
    await controller.signUp(
      email: email,
      password: password,
      fullName: fullName,
      role: _roleKey,
      phone: phone.isEmpty ? null : phone,
      commercialRegister:
          _isContractorOrDesigner ? commercialRegister : null,
    );
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
                    Text(
                      'إنشاء حساب جديد',
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
                      'انضم إلى منصة بُنيان الآن',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(
                        color: AppColor.secondaryText,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                    SizedBox(height: 24.h),
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
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 0.53,
                                  color: AppColor.grey200,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Container(
                                      width: 32.w,
                                      height: 32.h,
                                      padding: EdgeInsets.all(6.w),
                                      decoration: BoxDecoration(
                                        color: _roleIconBgColor(_roleKey),
                                        borderRadius: BorderRadius.circular(12.r),
                                      ),
                                      child: SvgPicture.asset(
                                        _roleIconPath(_roleKey),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'نوع الحساب',
                                          style: GoogleFonts.cairo(
                                            color: AppColor.secondaryText,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            height: 1.43,
                                          ),
                                        ),
                                        Text(
                                          _roleLabel(_roleKey),
                                          style: GoogleFonts.cairo(
                                            color: AppColor.darkText,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            height: 1.50,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: _navigateToRolesScreen,
                                  child: Text(
                                    'تغيير',
                                    style: GoogleFonts.cairo(
                                      color: AppColor.orange900,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      height: 1.43,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                          AuthTextField(
                            controller: fullNameController,
                            label: 'الاسم الكامل',
                            hintText: 'أدخل اسمك الكامل',
                            prefixIcon: Icons.person_outline,
                          ),
                          SizedBox(height: 16.h),
                          AuthTextField(
                            controller: phoneController,
                            label: 'رقم الجوال',
                            hintText: '05xxxxxxxx',
                            prefixIcon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]'),
                              ),
                            ],
                          ),
                          if (_isContractorOrDesigner) ...[
                            SizedBox(height: 16.h),
                            AuthTextField(
                              controller: commercialRegisterController,
                              label: 'رقم السجل التجاري',
                              hintText: 'ادخل السجل',
                              keyboardType: TextInputType.text,
                            ),
                          ],
                          SizedBox(height: 16.h),
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
                            hintText: 'أدخل كلمة مرور قوية',
                            prefixIcon: Icons.lock_outline,
                            obscureText: _obscurePassword,
                            onToggleObscure: () {
                              setState(
                                  () => _obscurePassword = !_obscurePassword);
                            },
                          ),
                          if (controller.state.error != null ||
                              _validationError != null) ...[
                            SizedBox(height: 8.h),
                            Text(
                              _validationError ?? controller.state.error!,
                              style: AppTextStyles.caption10.copyWith(
                                color: Colors.red,
                                fontSize: 11.sp,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                          SizedBox(height: 16.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() => _agreedToTerms = !_agreedToTerms);
                                },
                                child: Container(
                                  width: 24.w,
                                  height: 24.h,
                                  margin: EdgeInsets.only(left: 8.w),
                                  decoration: BoxDecoration(
                                    color: _agreedToTerms
                                        ? AppColor.orange900
                                        : AppColor.white,
                                    borderRadius: BorderRadius.circular(4.r),
                                    border: Border.all(
                                      color: AppColor.grey400,
                                    ),
                                  ),
                                  child: _agreedToTerms
                                      ? Icon(
                                          Icons.check,
                                          size: 16.sp,
                                          color: AppColor.white,
                                        )
                                      : null,
                                ),
                              ),
                              Expanded(
                                child: Wrap(
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Text(
                                      'أوافق على ',
                                      style: GoogleFonts.cairo(
                                        color: AppColor.secondaryText,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        height: 1.43,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        'الشروط والأحكام',
                                        style: GoogleFonts.cairo(
                                          color: AppColor.orange900,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.underline,
                                          height: 1.43,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      ' و ',
                                      style: GoogleFonts.cairo(
                                        color: AppColor.secondaryText,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        height: 1.43,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        'سياسة الخصوصية',
                                        style: GoogleFonts.cairo(
                                          color: AppColor.orange900,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.underline,
                                          height: 1.43,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          AuthPrimaryButton(
                            label: 'إنشاء الحساب',
                            onPressed:
                                _agreedToTerms ? _handleSignUp : null,
                            isLoading: controller.state.isLoading,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'لديك حساب بالفعل؟',
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
                              Routes.login,
                            );
                          },
                          child: Text(
                            'تسجيل الدخول',
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
