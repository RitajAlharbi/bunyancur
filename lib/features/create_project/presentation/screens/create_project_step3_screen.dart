import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/create_project_header.dart';
import '../widgets/create_project_progress_indicator.dart';

class CreateProjectStep3Screen extends StatelessWidget {
  const CreateProjectStep3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 24.w,
              right: 24.w,
              top: 12.h,
              bottom: 24.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CreateProjectHeader(title: 'إنشاء مشروع جديد'),
                SizedBox(height: 12.h),
                const CreateProjectProgressIndicator(
                  totalSteps: 3,
                  currentStep: 3,
                ),
                SizedBox(height: 24.h),
                Text(
                  'الخطوة الثالثة',
                  textAlign: TextAlign.right,
                  style: AppTextStyles.sectionTitle,
                ),
                SizedBox(height: 6.h),
                Text(
                  'هذه شاشة مؤقتة للخطوة الثالثة',
                  textAlign: TextAlign.right,
                  style: AppTextStyles.caption12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
