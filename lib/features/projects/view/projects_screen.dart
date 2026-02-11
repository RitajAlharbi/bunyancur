import 'dart:math' show pi;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../controller/projects_controller.dart';
import '../model/current_project_model.dart';
import '../model/project_status.dart';
import '../widgets/project_card.dart';
import '../widgets/projects_bottom_nav.dart';
import '../widgets/projects_pie_chart.dart';
import '../../../core/routing/routes.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key, this.initialFilter});

  final ProjectStatus? initialFilter;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProjectsController(initialFilter: initialFilter),
      child: const _ProjectsBody(),
    );
  }
}

class _ProjectsBody extends StatelessWidget {
  const _ProjectsBody();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
          child: Consumer<ProjectsController>(
            builder: (context, controller, _) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 16.h,
                      ).copyWith(bottom: 24.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _Header(),
                          SizedBox(height: 16.h),
                          _FilterPills(
                            selected: controller.selectedFilter,
                            onNavigateWithFilter: (status) =>
                                _navigateToProjectsWithFilter(context, status),
                          ),
                          SizedBox(height: 20.h),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(16.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.black.withValues(alpha: 0.06),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: ProjectsPieChart(
                              completedCount: controller.countByStatus(ProjectStatus.completed),
                              inProgressCount: controller.countByStatus(ProjectStatus.inProgress),
                              pendingCount: controller.countByStatus(ProjectStatus.pendingApproval),
                            ),
                          ),
                          SizedBox(height: 28.h),
                          _ProjectGrid(
                            projects: controller.filteredProjects,
                            onViewDetails: (p) =>
                                controller.onViewDetails(p, context),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ProjectsBottomNav(
                    currentIndex: controller.selectedBottomNavIndex,
                    onTap: (i) => controller.onBottomNavTap(i, context),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

void _navigateToProjectsWithFilter(BuildContext context, ProjectStatus filter) {
  Navigator.of(context).pushReplacementNamed(
    Routes.projectsScreen,
    arguments: filter.index,
  );
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(pi),
                child: Icon(
                  Icons.arrow_back,
                  size: 24.sp,
                  color: AppColor.orange900,
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Text(
            'مشاريعي الحالية',
            style: TextStyle(
              color: AppColor.orange900,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'Cairo',
            ),
          ),
        ),
      ],
    );
  }
}

class _FilterPills extends StatelessWidget {
  final ProjectStatus selected;
  final ValueChanged<ProjectStatus> onNavigateWithFilter;

  const _FilterPills({
    required this.selected,
    required this.onNavigateWithFilter,
  });

  static const _filters = [
    ProjectStatus.all,
    ProjectStatus.completed,
    ProjectStatus.pendingApproval,
    ProjectStatus.inProgress,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            for (var i = 0; i < _filters.length; i++) ...[
              if (i > 0) SizedBox(width: 8.w),
              _buildPill(_filters[i]),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPill(ProjectStatus status) {
    final isActive = selected == status;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onNavigateWithFilter(status),
        borderRadius: BorderRadius.circular(24.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: isActive ? AppColor.orange900 : AppColor.white,
            borderRadius: BorderRadius.circular(24.r),
            border: isActive
                ? null
                : Border.all(color: AppColor.orange900, width: 1),
          ),
          child: Text(
            status.label,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: isActive ? AppColor.white : AppColor.orange900,
              fontFamily: 'Cairo',
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}

class _ProjectGrid extends StatelessWidget {
  final List<CurrentProjectModel> projects;
  final void Function(CurrentProjectModel) onViewDetails;

  const _ProjectGrid({
    required this.projects,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    if (projects.isEmpty) {
      return SizedBox(
        height: 200.h,
        child: Center(
          child: Text(
            'لا توجد مشاريع',
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColor.grey600,
              fontFamily: 'Cairo',
            ),
          ),
        ),
      );
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 28.h,
            childAspectRatio: 0.56,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            final project = projects[index];
            return ProjectCard(
              project: project,
              onViewDetails: () => onViewDetails(project),
            );
          },
        );
      },
    );
  }
}
