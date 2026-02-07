import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../models/project_model.dart';
import '../controller/available_projects_controller.dart';
import '../model/filter_model.dart';
import '../widgets/available_project_card.dart';
import '../widgets/filter_pill_widget.dart';
import '../widgets/projects_bottom_nav.dart';

class AvailableProjectsScreen extends StatelessWidget {
  const AvailableProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AvailableProjectsController(),
      child: const _AvailableProjectsBody(),
    );
  }
}

class _AvailableProjectsBody extends StatelessWidget {
  const _AvailableProjectsBody();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        body: SafeArea(
          child: Consumer<AvailableProjectsController>(
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
                          _FilterPillsRow(
                            selectedFilter: controller.selectedFilter,
                            onFilterTap: controller.setFilter,
                          ),
                          SizedBox(height: 20.h),
                          _ProjectsGrid(
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
              child: Icon(
                Icons.arrow_back,
                size: 24.sp,
                color: AppColor.orange900,
              ),
            ),
          ),
        ),
        Center(
          child: Text(
            'المشاريع المتاحة',
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

class _FilterPillsRow extends StatelessWidget {
  final FilterType selectedFilter;
  final ValueChanged<FilterType> onFilterTap;

  const _FilterPillsRow({
    required this.selectedFilter,
    required this.onFilterTap,
  });

  static const _filters = [
    FilterType.all,
    FilterType.area,
    FilterType.projectType,
    FilterType.budget,
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
              FilterPillWidget(
                type: _filters[i],
                isActive: selectedFilter == _filters[i],
                onTap: () => onFilterTap(_filters[i]),
                activeColor: AppColor.orange900,
                borderColor: AppColor.orange900,
                inactiveTextColor: AppColor.orange900,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ProjectsGrid extends StatelessWidget {
  final List<ProjectModel> projects;
  final void Function(ProjectModel) onViewDetails;

  const _ProjectsGrid({
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
            return AvailableProjectCard(
              project: project,
              onViewDetails: () => onViewDetails(project),
            );
          },
        );
      },
    );
  }
}
