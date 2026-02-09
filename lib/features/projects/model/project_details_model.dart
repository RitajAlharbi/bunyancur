import 'package:flutter/foundation.dart';

import 'attachment_model.dart';
import 'current_project_model.dart';
import 'project_status.dart';
import 'review_model.dart';

@immutable
class ProjectDetailsModel {
  final String id;
  final String title;
  final String projectType;
  final ProjectStatus status;
  final String startDate;
  final String? completionDate;
  final String? submissionDate;
  final String? expectedApprovalDate;
  final String? expectedCompletionDate;
  final String city;
  final String area;
  final String budget;
  final String imagePath;
  final String clientName;
  final ReviewModel? review;
  final List<String> finalNotes;
  final List<String> submittedDocuments;
  final List<AttachmentModel> attachments;
  final String? mapLocation;

  const ProjectDetailsModel({
    required this.id,
    required this.title,
    required this.projectType,
    required this.status,
    required this.startDate,
    this.completionDate,
    this.submissionDate,
    this.expectedApprovalDate,
    this.expectedCompletionDate,
    required this.city,
    required this.area,
    required this.budget,
    required this.imagePath,
    required this.clientName,
    this.review,
    required this.finalNotes,
    required this.submittedDocuments,
    required this.attachments,
    this.mapLocation,
  });

  factory ProjectDetailsModel.fromCurrentProject(CurrentProjectModel project) {
    final bool completed = project.status == ProjectStatus.completed;
    final bool pending = project.status == ProjectStatus.pendingApproval;
    final bool inProgress = project.status == ProjectStatus.inProgress;

    return ProjectDetailsModel(
      id: project.id,
      title: project.title,
      projectType: completed || inProgress ? 'بناء كامل' : 'الاساسات',
      status: project.status,
      startDate: inProgress ? '5 يناير 2025' : '10 يناير 2025',
      completionDate: completed ? '15 فبراير 2025' : null,
      submissionDate: pending ? '1 نوفمبر 2025' : null,
      expectedApprovalDate: pending ? '10 نوفمبر 2025' : null,
      expectedCompletionDate: inProgress ? '10 نوفمبر 2026' : null,
      city: 'الخرج',
      area: inProgress ? '700' : (completed ? '600' : '500'),
      budget: inProgress ? '850,000' : (completed ? '920,000' : '580,000'),
      imagePath: project.imagePath,
      clientName: project.clientName,
      review: completed
          ? const ReviewModel(
              clientName: 'عبد الرحمن السالم',
              rating: 5,
              comment: 'مشروع رائع، تم التنفيذ بأعلى مستوى من الاحترافية والجودة.',
            )
          : null,
      finalNotes: inProgress
          ? const [
              'تم الانتهاء من أعمال الأساسات والعمدان',
              'جاري العمل على التشطيب للطابق الأرضي',
              'تم استلام مواد التشطيبات المطلوبة للمرحلة الرابعة',
            ]
          : const [
              'تم تسليم المشروع في الموعد المحدد',
              'جميع الاختبارات الفنية والمعاينات اجتازت المعايير المطلوبة',
            ],
      submittedDocuments: pending
          ? const [
              'تم إرفاق المخططات المعمارية',
              'تم إرفاق تصريح البناء',
              'تم تقديم عرض السعر التفصيلي',
              'تم إرفاق الجدول الزمني المقترح',
            ]
          : const [],
      attachments: pending
          ? const [
              AttachmentModel(id: '1', fileName: 'المخططات المعمارية.pdf', filePath: ''),
              AttachmentModel(id: '2', fileName: 'عرض السعر.pdf', filePath: ''),
              AttachmentModel(id: '3', fileName: 'الجدول الزمني pdf', filePath: ''),
            ]
          : inProgress
              ? const [
                  AttachmentModel(id: '1', fileName: 'مخطط البناء المعتمد.pdf', filePath: ''),
                  AttachmentModel(id: '2', fileName: 'صور التقدم في العمل.jpg', filePath: ''),
                  AttachmentModel(id: '3', fileName: 'قائمة المواد.pdf', filePath: ''),
                ]
              : const [
                  AttachmentModel(id: '1', fileName: 'شهادة إتمام البناء.pdf', filePath: ''),
                  AttachmentModel(id: '2', fileName: 'صور المشروع النهائية.jpg', filePath: ''),
                  AttachmentModel(id: '3', fileName: 'تقرير الجودة النهائي.pdf', filePath: ''),
                ],
      mapLocation: '24.7136,46.6753',
    );
  }
}
