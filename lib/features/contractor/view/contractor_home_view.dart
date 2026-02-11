import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/routing/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../projects/widgets/projects_bottom_nav.dart';
import '../controller/contractor_home_controller.dart';
import '../model/contractor_project_model.dart';

class ContractorHomeView extends StatelessWidget {
  const ContractorHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ContractorHomeController(),
      child: const _ContractorHomeBody(),
    );
  }
}

class _ContractorHomeBody extends StatelessWidget {
  const _ContractorHomeBody();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
          child: Consumer<ContractorHomeController>(
            builder: (context, controller, _) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 90.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.w,
                              vertical: 16.h,
                            ),
                            child: const _HeaderSection(),
                          ),
                          SizedBox(height: 16.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: const _SearchBar(),
                          ),
                          SizedBox(height: 24.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: _SectionHeader(
                              title: 'مشاريعي الحالية',
                              onTap: () => Navigator.of(context)
                                  .pushNamed(Routes.projectsScreen),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          _CurrentProjectsList(
                            projects: controller.currentProjects,
                          ),
                          SizedBox(height: 32.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: _SectionHeader(
                              title: 'المشاريع المتاحة',
                              onTap: () => Navigator.of(context)
                                  .pushNamed(Routes.availableProjectsScreen),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: _AvailableProjectsGrid(
                              projects: controller.availableProjects,
                            ),
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

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 24.r,
          backgroundColor: AppColor.white,
          child: Image.asset(
            'assets/icons/avatar.png',
            width: 48.w,
            height: 48.h,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.person,
                size: 24.sp,
                color: AppColor.grey400,
              );
            },
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'مرحبا محمد 👋',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: AppColor.grey600,
                  fontSize: 16.sp,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w400,
                  height: 1.40,
                  letterSpacing: 0.20,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'محمد عبدالعزيز',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: AppColor.orange900,
                  fontSize: 20.sp,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                  height: 1.20,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        Row(
          children: [
            _FavoriteIconButton(),
            SizedBox(width: 12.w),
            _NotificationIconButton(),
          ],
        ),
      ],
    );
  }
}

class _NotificationIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(Routes.notificationsScreen),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 48.w,
        height: 48.h,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColor.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColor.orange900,
            width: 1,
          ),
        ),
        child: Stack(
        clipBehavior: Clip.none,
        children: [
          Center(
            child: SvgPicture.asset(
              'assets/icons/notfication.svg',
              width: 24.w,
              height: 24.h,
              colorFilter: const ColorFilter.mode(
                AppColor.orange900,
                BlendMode.srcIn,
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 6.w,
              height: 6.h,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }
}

class _FavoriteIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(Routes.favoritesScreen),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 48.w,
        height: 48.h,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColor.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColor.orange900,
            width: 1,
          ),
        ),
        child: SvgPicture.asset(
        'assets/icons/Heart.svg',
        width: 24.w,
        height: 24.h,
        colorFilter: const ColorFilter.mode(
          AppColor.orange900,
          BlendMode.srcIn,
        ),
      ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: AppColor.grey100,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/icons/Search.svg',
                  width: 20.w,
                  height: 20.h,
                  colorFilter: const ColorFilter.mode(
                    AppColor.grey400,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  'البحث',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: AppColor.grey400,
                    fontSize: 14.sp,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w400,
                    height: 1.40,
                    letterSpacing: 0.20,
                  ),
                ),
              ],
            ),
          ),
          SvgPicture.asset(
            'assets/icons/Filter.svg',
            width: 20.w,
            height: 20.h,
            colorFilter: const ColorFilter.mode(
              AppColor.orange900,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const _SectionHeader({
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final titleFontSize = title == 'المشاريع المتاحة' ? 20.sp : 18.sp;

    final content = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: AppColor.orange900,
            fontSize: titleFontSize,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w700,
            height: title == 'المشاريع المتاحة' ? 1.20 : 1.50,
          ),
        ),
        Text(
          'مشاهدة الكل',
          style: TextStyle(
            color: AppColor.orange900,
            fontSize: 18.sp,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
      ],
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: content,
      );
    }
    return content;
  }
}

class _CurrentProjectsList extends StatelessWidget {
  final List<ContractorProjectModel> projects;

  const _CurrentProjectsList({required this.projects});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // خلفية بيضاء صافية خلف بطاقات "مشاريعي الحالية"
      child: SizedBox(
        height: 273.h,
        child: ListView.separated(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
          scrollDirection: Axis.horizontal,
          reverse: false,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final project = projects[index];
            return _CurrentProjectCard(project: project);
          },
          separatorBuilder: (_, __) => SizedBox(width: 16.w),
          itemCount: projects.length,
        ),
      ),
    );
  }
}

class _ProjectCardImage extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final double borderRadius;

  const _ProjectCardImage({
    required this.imagePath,
    required this.width,
    required this.height,
    this.borderRadius = 20,
  });

  static Widget _placeholder(double width, double height) => Container(
        width: width,
        height: height,
        color: AppColor.grey200,
        child: Icon(
          Icons.image_not_supported,
          color: AppColor.grey400,
          size: 48,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final isNetwork = imagePath.startsWith('http://') || imagePath.startsWith('https://');
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius.r),
      child: SizedBox(
        width: width,
        height: height,
        child: isNetwork
            ? Image.network(
                imagePath,
                width: width,
                height: height,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _placeholder(width, height),
              )
            : Image.asset(
                imagePath,
                width: width,
                height: height,
                fit: BoxFit.cover,
                package: null,
                errorBuilder: (_, __, ___) => _placeholder(width, height),
              ),
      ),
    );
  }
}

class _CurrentProjectCard extends StatelessWidget {
  final ContractorProjectModel project;

  const _CurrentProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withValues(alpha: 0.05),
            blurRadius: 60,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(14.w),
              child: _ProjectCardImage(
                imagePath: project.imagePath,
                width: double.infinity,
                height: 154.h,
                borderRadius: 20,
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 14.w,
                  end: 14.w,
                  bottom: 16.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        project.title,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: AppColor.black,
                          fontSize: 15.sp,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700,
                          height: 1.20,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (project.clientName.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Text(
                        project.clientName,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: AppColor.grey700,
                          fontSize: 10.sp,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.20,
                        ),
                      ),
                    ],
                    if (project.location.isNotEmpty) ...[
                      SizedBox(height: 2.h),
                      Text(
                        project.location,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: AppColor.grey700,
                          fontSize: 10.sp,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.20,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AvailableProjectsGrid extends StatelessWidget {
  final List<ContractorProjectModel> projects;

  const _AvailableProjectsGrid({required this.projects});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth - 16.w) / 2;
        // Card height: image (154) + image padding (14*2) + title (~40) + spacing (12) + button (~32) + bottom padding (16) ≈ 282
        final cardHeight = 282.h;
        
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 16.h,
            childAspectRatio: cardWidth / cardHeight,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            final project = projects[index];
            return _AvailableProjectCard(project: project);
          },
        );
      },
    );
  }
}

class _AvailableProjectCard extends StatelessWidget {
  final ContractorProjectModel project;

  const _AvailableProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withValues(alpha: 0.05),
            blurRadius: 60,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.all(14.w),
              child: _ProjectCardImage(
                imagePath: project.imagePath,
                width: double.infinity,
                height: 154.h,
                borderRadius: 20,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: 14.w,
                end: 14.w,
                bottom: 16.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    project.title,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppColor.black,
                      fontSize: 15.sp,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w700,
                      height: 1.20,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 12.h),
                  Center(
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: 32.h,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.orange900,
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Text(
                        'عرض تفاصيل',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: 12.sp,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
