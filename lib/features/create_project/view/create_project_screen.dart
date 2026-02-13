import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../controllers/create_project_controller.dart';
import '../widgets/create_project_dropdown_field.dart';
import '../widgets/create_project_header.dart';
import '../widgets/create_project_primary_button.dart';
import '../widgets/create_project_progress_indicator.dart';
import '../widgets/create_project_radio_option.dart';
import '../widgets/create_project_section_label.dart';
import '../widgets/create_project_text_field.dart';
import 'create_project_location_screen.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  late final CreateProjectController controller;
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    controller = CreateProjectController();
    controller.loadProjectTypes('contractor');
    nameController = TextEditingController(text: controller.data.title);
    descriptionController = TextEditingController(text: controller.data.description);
  }

  @override
  void dispose() {
    controller.dispose();
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
          child: AnimatedBuilder(
            animation: controller,
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
                      currentStep: 1,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'حدد تفاصيل المشروع الذي تريده',
                      textAlign: TextAlign.right,
                      style: AppTextStyles.sectionTitle,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'أدخل المعلومات الأساسية عن مشروعك',
                      textAlign: TextAlign.right,
                      style: AppTextStyles.caption12,
                    ),
                    SizedBox(height: 20.h),
                    const CreateProjectSectionLabel(
                      text: 'اسم المشروع',
                      isRequired: true,
                    ),
                    SizedBox(height: 8.h),
                    CreateProjectTextField(
                      controller: nameController,
                      hintText: 'اسم المشروع مطلوب',
                      onChanged: controller.setTitle,
                    ),
                    SizedBox(height: 16.h),
                    const CreateProjectSectionLabel(
                      text: 'نوع مشروعك',
                      isRequired: true,
                    ),
                    SizedBox(height: 8.h),
                    if (controller.isLoadingTypes)
                      const Center(child: CircularProgressIndicator())
                    else
                      CreateProjectDropdownField(
                        hintText: 'اختر نوع مشروعك',
                        value: controller.data.projectTypeName.isEmpty
                            ? null
                            : controller.data.projectTypeName,
                        items: controller.projectTypeNames,
                        onChanged: controller.setProjectTypeByName,
                      ),
                    if (controller.errorMessage != null &&
                        controller.projectTypeNames.isEmpty) ...[
                      SizedBox(height: 8.h),
                      Text(
                        controller.errorMessage!,
                        textAlign: TextAlign.right,
                        style: AppTextStyles.caption12
                            .copyWith(color: AppColor.orange900),
                      ),
                    ],
                    SizedBox(height: 16.h),
                    const CreateProjectSectionLabel(
                      text: 'مساحة المشروع بالمتر المربع',
                      isRequired: true,
                    ),
                    SizedBox(height: 8.h),
                    ...controller.projectAreas.map((area) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: CreateProjectRadioOption(
                          label: area,
                          isSelected: controller.data.areaRange == area,
                          onTap: () => controller.setAreaRange(area),
                        ),
                      );
                    }),
                    SizedBox(height: 4.h),
                    const CreateProjectSectionLabel(text: 'وصف المشروع'),
                    SizedBox(height: 8.h),
                    CreateProjectTextField(
                      controller: descriptionController,
                      hintText: 'اكتب وصفاً تفصيلياً لمشروعك... (اختياري)',
                      minLines: 3,
                      maxLines: 5,
                      onChanged: controller.setDescription,
                    ),
                    SizedBox(height: 24.h),
                    CreateProjectPrimaryButton(
                      label: 'التالي',
                      onPressed: controller.isStep1Valid
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CreateProjectLocationScreen(
                                    controller: controller,
                                  ),
                                ),
                              );
                            }
                          : null,
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
