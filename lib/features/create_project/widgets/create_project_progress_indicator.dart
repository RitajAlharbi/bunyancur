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
        final step = index + 1;
        final active = step <= currentStep;
        return Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 3.w),
            height: 6.h,
            decoration: BoxDecoration(
              color: active ? AppColor.orange900 : AppColor.grey200,
              borderRadius: BorderRadius.circular(99.r),
            ),
          ),
        );
      }),
    );
  }
}
