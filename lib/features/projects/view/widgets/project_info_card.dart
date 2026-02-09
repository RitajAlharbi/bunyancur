import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../model/project_details_model.dart';
import '../../model/project_status.dart';

class ProjectInfoCard extends StatelessWidget {
  final ProjectDetailsModel project;

  const ProjectInfoCard({super.key, required this.project});

  static const double _rowSpacing = 12;
  static const double _radius = 20;
  static const double _padding = 16;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[
      _InfoRow(label: 'عنوان المشروع', value: project.title),
      SizedBox(height: _rowSpacing.h),
      _InfoRow(label: 'نوع المشروع', value: project.projectType),
      SizedBox(height: _rowSpacing.h),
      _InfoRow(
        label: 'حالة المشروع',
        value: project.status.label,
        valueColor: _statusColor(project.status),
      ),
      SizedBox(height: _rowSpacing.h),
    ];

    if (project.status == ProjectStatus.pendingApproval) {
      if (project.submissionDate != null) {
        rows.add(_InfoRow(label: 'تاريخ التقديم', value: project.submissionDate!));
        rows.add(SizedBox(height: _rowSpacing.h));
      }
      if (project.expectedApprovalDate != null) {
        rows.add(_InfoRow(label: 'تاريخ الموافقة المتوقع', value: project.expectedApprovalDate!));
        rows.add(SizedBox(height: _rowSpacing.h));
      }
    } else {
      rows.add(_InfoRow(label: 'تاريخ البدء', value: project.startDate));
      rows.add(SizedBox(height: _rowSpacing.h));
      if (project.status == ProjectStatus.inProgress && project.expectedCompletionDate != null) {
        rows.add(_InfoRow(label: 'تاريخ الانتهاء المتوقع', value: project.expectedCompletionDate!));
        rows.add(SizedBox(height: _rowSpacing.h));
      } else if (project.status == ProjectStatus.completed && project.completionDate != null) {
        rows.add(_InfoRow(label: 'تاريخ الإنجاز', value: project.completionDate!));
        rows.add(SizedBox(height: _rowSpacing.h));
      }
    }

    rows.add(_InfoRow(label: 'المدينة', value: project.city));
    rows.add(SizedBox(height: _rowSpacing.h));
    rows.add(_InfoRow(label: 'الميزانية', value: '${project.budget} ريال${project.status == ProjectStatus.inProgress ? '' : ' سعودي'}'));
    rows.add(SizedBox(height: _rowSpacing.h));
    rows.add(_InfoRow(label: 'المساحة', value: '${project.area} متر مربع'));

    return Container(
      padding: EdgeInsets.all(_padding.w),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(_radius.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: rows,
      ),
    );
  }

  Color? _statusColor(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.pendingApproval:
        return AppColor.orange900;
      case ProjectStatus.inProgress:
        return AppColor.statusInProgressText;
      default:
        return null;
    }
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColor.grey600,
              fontFamily: 'Cairo',
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: valueColor ?? AppColor.black,
              fontFamily: 'Cairo',
            ),
            textAlign: TextAlign.right,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
