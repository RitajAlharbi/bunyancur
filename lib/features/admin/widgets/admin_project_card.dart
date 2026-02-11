import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/admin_project_model.dart';

class AdminProjectCard extends StatelessWidget {
  final AdminProject project;
  final VoidCallback onView;
  final VoidCallback onDelete;
  final VoidCallback? onMarkCompleted;

  const AdminProjectCard({
    super.key,
    required this.project,
    required this.onView,
    required this.onDelete,
    this.onMarkCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildHeader(),
          SizedBox(height: 8.h),
          _buildOwnerAndContractor(),
          SizedBox(height: 12.h),
          _buildProgress(),
          SizedBox(height: 12.h),
          _buildActions(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: TextDirection.rtl,
      children: [
        Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: AppColor.grey100,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            Icons.apartment_rounded,
            color: AppColor.orange900,
            size: 22.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                project.title,
                textAlign: TextAlign.right,
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                ),
              ),
              SizedBox(height: 4.h),
              Align(
                alignment: Alignment.centerRight,
                child: _StatusChip(status: project.status),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOwnerAndContractor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'المالك: ${project.ownerName}',
          textAlign: TextAlign.right,
          style: AppTextStyles.caption12,
        ),
        SizedBox(height: 4.h),
        Text(
          'المقاول: ${project.contractorName}',
          textAlign: TextAlign.right,
          style: AppTextStyles.caption12,
        ),
      ],
    );
  }

  Widget _buildProgress() {
    final percent = project.progressPercent.clamp(0, 100);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          textDirection: TextDirection.rtl,
          children: [
            Text(
              'نسبة الإنجاز',
              style: AppTextStyles.caption12,
              textAlign: TextAlign.right,
            ),
            SizedBox(width: 8.w),
            Text(
              '$percent%',
              style: AppTextStyles.caption12.copyWith(
                color: AppColor.black,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
        SizedBox(height: 6.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(100.r),
          child: LinearProgressIndicator(
            minHeight: 6.h,
            value: percent / 100,
            backgroundColor: AppColor.grey200,
            valueColor: AlwaysStoppedAnimation<Color>(AppColor.black),
          ),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    final canMarkCompleted =
        onMarkCompleted != null && project.status != AdminProjectStatus.completed;

    // RTL horizontal row: [عرض 👁] [قبول ✔] [حذف 🗑] with equal spacing
    final list = <Widget>[
      _ActionButton(
        label: 'عرض',
        icon: Icons.remove_red_eye_outlined,
        color: AppColor.orange900,
        onPressed: onView,
      ),
      if (canMarkCompleted)
        _ActionButton(
          label: 'قبول',
          iconWidget: Image.asset(
            'assets/icons/Icon true.jpg',
            width: 18.w,
            height: 18.h,
          ),
          color: Colors.green,
          onPressed: onMarkCompleted!,
        ),
      _ActionButton(
        label: 'حذف',
        icon: Icons.delete_outline,
        color: Colors.red,
        onPressed: onDelete,
      ),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      textDirection: TextDirection.rtl,
      children: [
        for (int i = 0; i < list.length; i++) ...[
          if (i > 0) SizedBox(width: 16.w),
          list[i],
        ],
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;
  final IconData? icon;
  final Widget? iconWidget;

  const _ActionButton({
    required this.label,
    required this.color,
    required this.onPressed,
    this.icon,
    this.iconWidget,
  }) : assert(icon != null || iconWidget != null);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        textDirection: TextDirection.rtl,
        children: [
          if (icon != null)
            Icon(icon!, size: 18.sp, color: color)
          else
            iconWidget!,
          SizedBox(width: 6.w),
          Text(
            label,
            style: AppTextStyles.caption12.copyWith(color: color),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final AdminProjectStatus status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color background;
    Color foreground;

    switch (status) {
      case AdminProjectStatus.newRequest:
        background = AppColor.grey100;
        foreground = AppColor.orange900;
        break;
      case AdminProjectStatus.inProgress:
        background = AppColor.orange900.withValues(alpha: 0.08);
        foreground = AppColor.orange900;
        break;
      case AdminProjectStatus.completed:
        background = AppColor.grey100;
        foreground = AppColor.black;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Text(
        status.label,
        style: AppTextStyles.caption12.copyWith(
          color: foreground,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }
}

