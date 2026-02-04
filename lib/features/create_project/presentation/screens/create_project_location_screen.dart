import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../controllers/create_project_controller.dart';
import '../widgets/create_project_header.dart';
import '../widgets/create_project_map_placeholder.dart';
import '../widgets/create_project_primary_button.dart';
import '../widgets/create_project_progress_indicator.dart';
import '../widgets/create_project_section_label.dart';
import '../widgets/create_project_secondary_button.dart';
import '../widgets/create_project_text_field.dart';
import 'create_project_step3_screen.dart';

class CreateProjectLocationScreen extends StatefulWidget {
  final CreateProjectController controller;

  const CreateProjectLocationScreen({
    super.key,
    required this.controller,
  });

  @override
  State<CreateProjectLocationScreen> createState() =>
      _CreateProjectLocationScreenState();
}

class _CreateProjectLocationScreenState
    extends State<CreateProjectLocationScreen> {
  late final TextEditingController addressController;
  late final TextEditingController cityController;
  late final TextEditingController districtController;

  @override
  void initState() {
    super.initState();
    addressController = TextEditingController(text: widget.controller.data.address);
    cityController = TextEditingController(text: widget.controller.data.city);
    districtController = TextEditingController(text: widget.controller.data.district);
  }

  @override
  void dispose() {
    addressController.dispose();
    cityController.dispose();
    districtController.dispose();
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
                      totalSteps: 3,
                      currentStep: 2,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'حدد موقع البناء',
                      textAlign: TextAlign.right,
                      style: AppTextStyles.sectionTitle,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'أدخل عنوان الموقع أو حدده على الخريطة',
                      textAlign: TextAlign.right,
                      style: AppTextStyles.caption12,
                    ),
                    SizedBox(height: 20.h),
                    const CreateProjectSectionLabel(
                      text: 'العنوان',
                      isRequired: true,
                    ),
                    SizedBox(height: 8.h),
                    CreateProjectTextField(
                      controller: addressController,
                      hintText: 'مثال: الخرج، حي النخيل، شارع التخصصي',
                      onChanged: widget.controller.updateAddress,
                      prefixIcon: Icons.location_on_outlined,
                    ),
                    SizedBox(height: 16.h),
                    const CreateProjectSectionLabel(text: 'المدينة'),
                    SizedBox(height: 8.h),
                    CreateProjectTextField(
                      controller: cityController,
                      hintText: 'الخرج',
                      onChanged: widget.controller.updateCity,
                    ),
                    SizedBox(height: 16.h),
                    const CreateProjectSectionLabel(text: 'الحي'),
                    SizedBox(height: 8.h),
                    CreateProjectTextField(
                      controller: districtController,
                      hintText: 'النخيل',
                      onChanged: widget.controller.updateDistrict,
                    ),
                    SizedBox(height: 20.h),
                    const CreateProjectSectionLabel(text: 'حدد الموقع على الخريطة'),
                    SizedBox(height: 10.h),
                    const CreateProjectMapPlaceholder(),
                    SizedBox(height: 10.h),
                    Text(
                      'سيساعد تحديد الموقع بدقة المقاولين في تقديم عروض أفضل',
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CreateProjectStep3Screen(),
                                ),
                              );
                            },
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
