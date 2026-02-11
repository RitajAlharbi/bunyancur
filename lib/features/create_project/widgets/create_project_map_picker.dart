import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../controllers/create_project_controller.dart';

class CreateProjectMapPicker extends StatelessWidget {
  final CreateProjectController controller;
  final VoidCallback onTap;

  const CreateProjectMapPicker({
    super.key,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.h,
      decoration: BoxDecoration(
        color: AppColor.grey100,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.grey200),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            child: Stack(
              children: [
                if (controller.isFetchingLocation)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                IgnorePointer(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 48.w,
                          height: 48.w,
                          decoration: BoxDecoration(
                            color: AppColor.grey200,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.place_outlined,
                            color: AppColor.orange900,
                            size: 26.sp,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'انقر لتحديد الموقع على الخريطة',
                          style: AppTextStyles.body,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'يمكنك سحب المؤشر لتحديد الموقع بدقة',
                          style: AppTextStyles.caption12,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
