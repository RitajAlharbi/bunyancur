import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../model/project_details_model.dart';
import '../../model/project_status.dart';

class HeroImageSection extends StatelessWidget {
  final ProjectDetailsModel project;

  const HeroImageSection({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(28.r),
            bottomRight: Radius.circular(28.r),
          ),
          child: SizedBox(
            height: 280.h,
            width: double.infinity,
            child: project.imagePath.startsWith('http') ||
                    project.imagePath.startsWith('https')
                ? Image.network(
                    project.imagePath,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    isAntiAlias: true,
                    errorBuilder: (_, __, ___) => _placeholder(context),
                  )
                : Image.asset(
                    project.imagePath,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    isAntiAlias: true,
                    errorBuilder: (_, __, ___) => _placeholder(context),
                  ),
          ),
        ),
        Positioned(
          top: 16.h,
          right: 16.w,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColor.white.withValues(alpha: 0.9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward,
                size: 24.sp,
                color: AppColor.orange900,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 16.h,
          right: 16.w,
          child: _StatusBadge(status: project.status),
        ),
      ],
    );
  }

  Widget _placeholder(BuildContext context) => Container(
        height: 280.h,
        width: double.infinity,
        color: AppColor.grey200,
        child: Icon(
          Icons.image_not_supported,
          color: AppColor.grey400,
          size: 48.sp,
        ),
      );
}

class _StatusBadge extends StatelessWidget {
  final ProjectStatus status;

  const _StatusBadge({required this.status});

  String _getStatusLabel() {
    switch (status) {
      case ProjectStatus.completed:
        return 'مكتمل';
      case ProjectStatus.inProgress:
        return 'قيد التنفيذ';
      case ProjectStatus.pendingApproval:
        return 'انتظار الموافقة';
      case ProjectStatus.all:
        return 'الكل';
    }
  }

  Color _getBadgeBgColor() {
    switch (status) {
      case ProjectStatus.completed:
        return AppColor.statusCompletedBg;
      case ProjectStatus.inProgress:
        return AppColor.heroBadgeInProgressBg;
      case ProjectStatus.pendingApproval:
        return AppColor.heroBadgePendingBg;
      case ProjectStatus.all:
        return AppColor.grey200;
    }
  }

  Color _getBadgeTextColor() {
    switch (status) {
      case ProjectStatus.completed:
        return AppColor.statusCompletedText;
      case ProjectStatus.inProgress:
        return AppColor.white;
      case ProjectStatus.pendingApproval:
        return AppColor.heroBadgePendingText;
      case ProjectStatus.all:
        return AppColor.grey700;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: _getBadgeBgColor(),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        _getStatusLabel(),
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          color: _getBadgeTextColor(),
          fontFamily: 'Cairo',
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
