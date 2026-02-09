import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../model/project_details_model.dart';
import '../../model/project_status.dart';

class CompletionBanner extends StatelessWidget {
  final ProjectDetailsModel project;

  const CompletionBanner({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    if (project.status != ProjectStatus.completed || project.completionDate == null) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColor.statusCompletedBg,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'تم إنجاز المشروع بنجاح!',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColor.statusCompletedText,
                    fontFamily: 'Cairo',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  'تاريخ الإنجاز: ${project.completionDate}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColor.statusCompletedText.withValues(alpha: 0.8),
                    fontFamily: 'Cairo',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            width: 32.w,
            height: 32.h,
            decoration: BoxDecoration(
              color: AppColor.statusCompletedBg,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColor.statusCompletedText,
                width: 2,
              ),
            ),
            child: Icon(
              Icons.check,
              size: 18.sp,
              color: AppColor.statusCompletedText,
            ),
          ),
        ],
      ),
    );
  }
}
