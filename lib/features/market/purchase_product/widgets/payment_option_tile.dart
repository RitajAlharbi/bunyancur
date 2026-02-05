import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class PaymentOptionTile extends StatelessWidget {
  final String label;
  final bool isSelected;
  final bool isDisabled;
  final String? helperText;
  final VoidCallback onTap;

  const PaymentOptionTile({
    super.key,
    required this.label,
    required this.isSelected,
    required this.isDisabled,
    required this.onTap,
    this.helperText,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isDisabled ? 0.6 : 1,
      child: InkWell(
        onTap: isDisabled ? null : onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            color: isDisabled ? AppColor.grey100 : AppColor.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColor.grey200,
              width: 1.59,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 12.h),
                    Text(
                      label,
                      textAlign: TextAlign.right,
                      style: AppTextStyles.body.copyWith(
                        color: AppColor.grey600,
                      ),
                    ),
                    if (helperText != null) ...[
                      SizedBox(height: 2.h),
                      Text(
                        helperText!,
                        textAlign: TextAlign.right,
                        style: AppTextStyles.caption12.copyWith(
                          color: AppColor.grey400,
                        ),
                      ),
                      SizedBox(height: 12.h),
                    ] else
                      SizedBox(height: 12.h),
                  ],
                ),
              ),
              Container(
                width: 20.w,
                height: 20.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppColor.orange900 : AppColor.grey200,
                    width: 1.2,
                  ),
                  color:
                      isSelected ? AppColor.orange900 : Colors.transparent,
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 6.w,
                          height: 6.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
