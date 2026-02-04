import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_bottom_nav.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../market/views/market_screen.dart';
import '../controller/available_projects_controller.dart';
import '../model/project_model.dart';

class AvailableProjectsPage extends StatefulWidget {
  const AvailableProjectsPage({super.key});

  @override
  State<AvailableProjectsPage> createState() => _AvailableProjectsPageState();
}

class _AvailableProjectsPageState extends State<AvailableProjectsPage> {
  late final AvailableProjectsController controller;

  @override
  void initState() {
    super.initState();
    controller = AvailableProjectsController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: AppBottomNav(
          // Treat index 1 as the "projects" tab, matching the existing nav style.
          currentIndex: 1,
          onTap: (index) {
            if (index == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            } else if (index == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const AvailableProjectsPage(),
                ),
              );
            } else if (index == 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MarketScreen()),
              );
            }
          },
        ),
        body: SafeArea(
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              final projects = controller.filteredProjects;
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 24.h),
                      _Header(),
                      SizedBox(height: 24.h),
                      _FilterChipsRow(
                        selectedChip: controller.selectedChip,
                        onChipSelected: controller.selectChip,
                      ),
                      SizedBox(height: 24.h),
                      _ProjectsGrid(projects: projects),
                      SizedBox(height: 110.h),
                    ],
                  ),
                ),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Small arrow icon on the right side (in RTL this is visually right).
        Container(
          width: 28.w,
          height: 28.w,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Center(
            child: SvgPicture.asset(
              'assets/icons/Vector.svg',
              width: 16.w,
              height: 16.h,
              colorFilter: ColorFilter.mode(
                AppColor.orange900,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        const Spacer(),
        Text(
          'المشاريع المتاحة',
          style: AppTextStyles.title,
        ),
      ],
    );
  }
}

class _FilterChipsRow extends StatelessWidget {
  final ProjectFilterChip selectedChip;
  final ValueChanged<ProjectFilterChip> onChipSelected;

  const _FilterChipsRow({
    required this.selectedChip,
    required this.onChipSelected,
  });

  @override
  Widget build(BuildContext context) {
    final chips = ProjectFilterChip.values;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final chip in chips) ...[
            _FilterChipItem(
              label: chip.labelAr,
              isActive: chip == selectedChip,
              onTap: () => onChipSelected(chip),
            ),
            if (chip != chips.last) SizedBox(width: 10.w),
          ],
        ],
      ),
    );
  }
}

class _FilterChipItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterChipItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 38.h,
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        decoration: BoxDecoration(
          color: isActive ? AppColor.orange900 : Colors.transparent,
          border: Border.all(color: AppColor.orange900, width: 0.5),
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.body.copyWith(
              fontWeight: FontWeight.w500,
              color: isActive ? Colors.white : AppColor.orange900,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectsGrid extends StatelessWidget {
  final List<ProjectModel> projects;

  const _ProjectsGrid({required this.projects});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: projects.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 0.63,
      ),
      itemBuilder: (context, index) {
        final project = projects[index];
        return _ProjectCard(project: project);
      },
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final ProjectModel project;

  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 60,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: _buildImage(),
          ),
          SizedBox(height: 10.h),
          Text(
            project.titleAr,
            textAlign: TextAlign.right,
            style: GoogleFonts.cairo(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: AppColor.grey700,
            ),
          ),
          SizedBox(height: 8.h),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 24.h,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: AppColor.orange900,
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: Center(
                child: Text(
                  project.ctaTextAr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cairo(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (project.imagePathOrUrl.startsWith('http')) {
      return Image.network(
        project.imagePathOrUrl,
        width: double.infinity,
        height: 154.h,
        fit: BoxFit.cover,
      );
    }
    return Image.asset(
      project.imagePathOrUrl,
      width: double.infinity,
      height: 154.h,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: double.infinity,
          height: 154.h,
          decoration: BoxDecoration(
            color: AppColor.grey200,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Icon(
            Icons.image,
            size: 40.sp,
            color: AppColor.grey400,
          ),
        );
      },
    );
  }
}

