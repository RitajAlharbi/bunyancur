import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../model/project_details_model.dart';
import '../../model/project_status.dart';

class NotesSection extends StatelessWidget {
  final ProjectDetailsModel project;

  const NotesSection({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    if (project.status == ProjectStatus.pendingApproval && project.submittedDocuments.isNotEmpty) {
      return _PendingDocumentsSection(items: project.submittedDocuments);
    }
    if (project.status == ProjectStatus.inProgress && project.finalNotes.isNotEmpty) {
      return _InProgressNotesSection(notes: project.finalNotes);
    }
    return const SizedBox.shrink();
  }
}

class _PendingDocumentsSection extends StatelessWidget {
  final List<String> items;

  const _PendingDocumentsSection({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20.r),
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
        children: [
          Row(
            children: [
              Icon(Icons.checklist, size: 20.sp, color: AppColor.orange900),
              SizedBox(width: 8.w),
              Text(
                'المستندات المقدمة',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...items.asMap().entries.map((e) {
            return Padding(
              padding: EdgeInsets.only(bottom: e.key < items.length - 1 ? 12.h : 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle, size: 20.sp, color: AppColor.orange900),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      e.value,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColor.grey700,
                        fontFamily: 'Cairo',
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _InProgressNotesSection extends StatelessWidget {
  final List<String> notes;

  const _InProgressNotesSection({required this.notes});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.notesContainerInProgressBg,
        borderRadius: BorderRadius.circular(20.r),
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
        children: [
          Row(
            children: [
              Icon(Icons.description, size: 20.sp, color: AppColor.orange900),
              SizedBox(width: 8.w),
              Text(
                'الملاحظات',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.orange900,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...notes.asMap().entries.map((e) {
            return Padding(
              padding: EdgeInsets.only(bottom: e.key < notes.length - 1 ? 10.h : 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 6.h),
                    width: 6.w,
                    height: 6.h,
                    decoration: const BoxDecoration(
                      color: AppColor.orange900,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      e.value,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColor.grey700,
                        fontFamily: 'Cairo',
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
