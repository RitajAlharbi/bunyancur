import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';

class CreateProjectProgressIndicator extends StatelessWidget {
  final int totalSteps;
  final int currentStep;

  const CreateProjectProgressIndicator({
    super.key,
    required this.totalSteps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        final isActive = index < currentStep;
        return Expanded(
          child: Container(
            height: 4.h,
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              color: isActive ? AppColor.orange900 : AppColor.grey200,
              borderRadius: BorderRadius.circular(100.r),
            ),
          ),
        );
      }),
    );
  }
}
