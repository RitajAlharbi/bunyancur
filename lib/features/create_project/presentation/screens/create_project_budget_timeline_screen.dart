import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../controllers/create_project_controller.dart';
import '../widgets/create_project_dropdown_field.dart';
import '../widgets/create_project_header.dart';
import '../widgets/create_project_primary_button.dart';
import '../widgets/create_project_progress_indicator.dart';
import '../widgets/create_project_section_label.dart';
import '../widgets/create_project_secondary_button.dart';
import 'create_project_upload_summary_screen.dart';

class CreateProjectBudgetTimelineScreen extends StatefulWidget {
  final CreateProjectController controller;

  const CreateProjectBudgetTimelineScreen({
    super.key,
    required this.controller,
  });

  @override
  State<CreateProjectBudgetTimelineScreen> createState() =>
      _CreateProjectBudgetTimelineScreenState();
}

class _CreateProjectBudgetTimelineScreenState
    extends State<CreateProjectBudgetTimelineScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
          child: AnimatedBuilder(
            animation: widget.controller,
            builder: (context, _) {
              return SingleChildScrollView(
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
                      totalSteps: 4,
                      currentStep: 3,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'الميزانية والجدول الزمني',
                      textAlign: TextAlign.right,
                      style: AppTextStyles.sectionTitle,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'حدد ميزانيتك والمدة الزمنية المتوقعة للمشروع',
                      textAlign: TextAlign.right,
                      style: AppTextStyles.caption12,
                    ),
                    SizedBox(height: 20.h),
                    const CreateProjectSectionLabel(
                      text: 'نطاق الميزانية',
                      isRequired: true,
                    ),
                    SizedBox(height: 8.h),
                    CreateProjectDropdownField(
                      hintText: 'اختر نطاق ميزانيتك',
                      value: widget.controller.selectedBudgetRange,
                      items: widget.controller.budgetRanges,
                      onChanged: widget.controller.setBudgetRange,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'الميزانية تقريبية وقد تختلف حسب العروض المقدمة',
                      textAlign: TextAlign.right,
                      style: AppTextStyles.caption12,
                    ),
                    SizedBox(height: 18.h),
                    const CreateProjectSectionLabel(
                      text: 'المدة الزمنية المتوقعة',
                      isRequired: true,
                    ),
                    SizedBox(height: 8.h),
                    CreateProjectDropdownField(
                      hintText: 'اختر المده المناسبه لمشروعك',
                      value: widget.controller.selectedTimeline,
                      items: widget.controller.timelines,
                      onChanged: widget.controller.setExpectedDuration,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'الجدول الزمني قابل للتعديل بالاتفاق مع المقاول',
                      textAlign: TextAlign.right,
                      style: AppTextStyles.caption12,
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      children: [
                        Expanded(
                          child: CreateProjectSecondaryButton(
                            label: 'السابق',
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: CreateProjectPrimaryButton(
                            label: 'التالي',
                            onPressed: widget.controller.isStep3Valid
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            CreateProjectUploadSummaryScreen(
                                          controller: widget.controller,
                                        ),
                                      ),
                                    );
                                  }
                                : null,
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
    );
  }
}
