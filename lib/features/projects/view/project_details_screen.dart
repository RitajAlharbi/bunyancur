import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../controller/project_details_controller.dart';
import '../model/current_project_model.dart';
import '../model/project_details_model.dart';
import '../model/project_status.dart';
import '../widgets/projects_bottom_nav.dart';
import 'widgets/attachments_section.dart';
import 'widgets/completion_banner.dart';
import 'widgets/continue_project_button.dart';
import 'widgets/final_notes_section.dart';
import 'widgets/hero_image_section.dart';
import 'widgets/info_notice_banner.dart';
import 'widgets/map_preview_section.dart';
import 'widgets/notes_section.dart';
import 'widgets/pending_approval_banner.dart';
import 'widgets/project_info_card.dart';
import 'widgets/rating_section.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final CurrentProjectModel project;

  const ProjectDetailsScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final detailsModel = ProjectDetailsModel.fromCurrentProject(project);
    return ChangeNotifierProvider(
      create: (_) => ProjectDetailsController(project: detailsModel),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: const Color(0xFFF7F7F7),
          body: SafeArea(
            child: Consumer<ProjectDetailsController>(
              builder: (context, controller, _) {
                final p = controller.project;
                final isPending = p.status == ProjectStatus.pendingApproval;
                final isInProgress = p.status == ProjectStatus.inProgress;
                final isCompleted = p.status == ProjectStatus.completed;

                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            HeroImageSection(project: p),
                            if (isPending) PendingApprovalBanner(),
                            if (isCompleted) CompletionBanner(project: p),
                            if (isPending || isInProgress || isCompleted) ...[
                              SizedBox(height: 16.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    ProjectInfoCard(project: p),
                                    if (isPending) ...[
                                      SizedBox(height: 20.h),
                                      InfoNoticeBanner(),
                                    ],
                                    if (isPending || isInProgress) ...[
                                      SizedBox(height: 20.h),
                                      NotesSection(project: p),
                                    ],
                                    if (isCompleted && p.finalNotes.isNotEmpty) ...[
                                      SizedBox(height: 20.h),
                                      FinalNotesSection(notes: p.finalNotes),
                                    ],
                                    if (isCompleted && p.review != null) ...[
                                      SizedBox(height: 20.h),
                                      RatingSection(review: p.review!),
                                    ],
                                    SizedBox(height: 20.h),
                                    AttachmentsSection(attachments: p.attachments),
                                    SizedBox(height: 20.h),
                                    MapPreviewSection(
                                      location: p.mapLocation,
                                      projectImagePath: p.imagePath,
                                    ),
                                    if (isInProgress) ...[
                                      SizedBox(height: 24.h),
                                      ContinueProjectButton(onPressed: () {}),
                                    ] else
                                      SizedBox(height: 24.h),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    ProjectsBottomNav(
                      currentIndex: 1,
                      onTap: (i) => controller.onBottomNavTap(i, context),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
