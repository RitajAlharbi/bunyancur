import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../model/project_status.dart';

class StatusBadge extends StatelessWidget {
  final ProjectStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    if (status == ProjectStatus.all) return const SizedBox.shrink();
    final (bg, text) = _colorsForStatus(status);
    final isCompleted = status == ProjectStatus.completed;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20.r),
        border: isCompleted
            ? Border.all(color: AppColor.statusCompletedText, width: 1)
            : null,
      ),
      child: Text(
        status.label,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
          color: text,
          fontFamily: 'Cairo',
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  static (Color bg, Color text) _colorsForStatus(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.completed:
        return (AppColor.statusCompletedBg, AppColor.statusCompletedText);
      case ProjectStatus.inProgress:
        return (AppColor.statusInProgressBg, AppColor.statusInProgressText);
      case ProjectStatus.pendingApproval:
        return (AppColor.statusPendingBg, AppColor.statusPendingText);
      case ProjectStatus.all:
        return (AppColor.grey200, AppColor.grey700);
    }
  }
}
