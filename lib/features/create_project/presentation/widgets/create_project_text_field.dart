import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class CreateProjectTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int minLines;
  final int maxLines;
  final ValueChanged<String> onChanged;
  final IconData? prefixIcon;
  final VoidCallback? onPrefixIconTap;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? suffixText;

  const CreateProjectTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
    this.minLines = 1,
    this.maxLines = 1,
    this.prefixIcon,
    this.onPrefixIconTap,
    this.keyboardType,
    this.inputFormatters,
    this.suffixText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.right,
      minLines: minLines,
      maxLines: maxLines,
      style: AppTextStyles.body,
      onChanged: onChanged,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.body.copyWith(color: AppColor.grey400),
        filled: true,
        fillColor: AppColor.grey100,
        prefixIcon: prefixIcon == null
            ? null
            : GestureDetector(
                onTap: onPrefixIconTap,
                child: Icon(
                  prefixIcon,
                  color: AppColor.grey500,
                  size: 20.sp,
                ),
              ),
        suffixText: suffixText,
        suffixStyle: AppTextStyles.body.copyWith(color: AppColor.grey700),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColor.grey200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColor.grey200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColor.orange900),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
    );
  }
}
