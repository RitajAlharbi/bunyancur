import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../controllers/home_controller.dart';
import '../core/widgets/app_bottom_nav.dart';
import '../models/project_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (_) => HomeController(),
      child: const _HomeViewBody(),
    );
  }
}

class _HomeViewBody extends StatelessWidget {
  const _HomeViewBody();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
          child: Consumer<HomeController>(
            builder: (context, controller, _) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 90.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 16.h,
                      ),
                      child: _HeaderSection(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: _SearchBar(),
                    ),
                    SizedBox(height: 24.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: _SectionHeader(
                        title: 'مشاريعي الحالية',
                        actionText: 'مشاهدة الكل',
                      ),
                    ),
                    SizedBox(height: 16.h),
                    _CurrentProjectsList(projects: controller.currentProjects),
                    SizedBox(height: 24.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: _SectionHeader(
                        title: 'المشاريع المتاحة',
                        actionText: 'مشاهدة الكل',
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
              );
            },
          ),
        ),
        bottomNavigationBar: Consumer<HomeController>(
          builder: (context, controller, _) {
            return AppBottomNav(
              currentIndex: controller.selectedIndex,
              onTap: controller.onBottomNavTap,
            );
          },
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final iconColor = theme.iconTheme.color;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 24.r,
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
          child: Image.asset(
            'assets/icons/avatar.png',
            width: 40.w,
            height: 40.h,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.person,
                size: 24.sp,
                color: theme.colorScheme.onSurfaceVariant,
              );
            },
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '👋 مرحباً محمد',
                style: textTheme.bodyMedium,
                textAlign: TextAlign.right,
              ),
              SizedBox(height: 4.h),
              Text(
                'محمد عبدالعزيز',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        Row(
          children: [
            _NotificationIconButton(iconColor: iconColor),
            SizedBox(width: 12.w),
            _HeaderIconButton(
              assetPath: 'assets/icons/Heart.svg',
              iconColor: iconColor,
            ),
          ],
        ),
      ],
    );
  }
}

class _NotificationIconButton extends StatelessWidget {
  final Color? iconColor;

  const _NotificationIconButton({required this.iconColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        shape: BoxShape.circle,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SvgPicture.asset(
            'assets/icons/notfication.svg',
            width: 24.w,
            height: 24.h,
            colorFilter: iconColor != null
                ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
                : null,
          ),
          Positioned(
            right: -2.w,
            top: -2.h,
            child: Container(
              width: 8.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  final String assetPath;
  final Color? iconColor;

  const _HeaderIconButton({
    required this.assetPath,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        assetPath,
        width: 24.w,
        height: 24.h,
        colorFilter: iconColor != null
            ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
            : null,
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/Search.svg',
            width: 24.w,
            height: 24.h,
            colorFilter: ColorFilter.mode(
              theme.iconTheme.color ?? colorScheme.onSurfaceVariant,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: 'البحث',
                hintStyle: theme.textTheme.bodyMedium,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          SvgPicture.asset(
            'assets/icons/Filter.svg',
            width: 24.w,
            height: 24.h,
            colorFilter: ColorFilter.mode(
              theme.iconTheme.color ?? colorScheme.onSurfaceVariant,
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
  final String actionText;

  const _SectionHeader({
    required this.title,
    required this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {},
          child: Text(
            actionText,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.primary,
            ),
          ),
        ),
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _CurrentProjectsList extends StatelessWidget {
  final List<ProjectModel> projects;

  const _CurrentProjectsList({required this.projects});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardTheme = theme.cardTheme;
    final colorScheme = theme.colorScheme;

    return SizedBox(
      height: 260.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemBuilder: (context, index) {
          final project = projects[index];
          return SizedBox(
            width: 220.w,
            child: Card(
              elevation: cardTheme.elevation ?? 4,
              shape: cardTheme.shape ??
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.r),
                  ),
              color: cardTheme.color ?? colorScheme.surface,
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.asset(
                      project.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: colorScheme.surfaceContainerHighest,
                          child: Icon(
                            Icons.image_not_supported,
                            color: colorScheme.onSurfaceVariant,
                            size: 48.sp,
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          project.title,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(height: 4.h),
                        if (project.clientName.isNotEmpty)
                          Text(
                            project.clientName,
                            style: theme.textTheme.bodySmall,
                            textAlign: TextAlign.right,
                          ),
                        if (project.status.isNotEmpty) ...[
                          SizedBox(height: 4.h),
                          Text(
                            project.status,
                            style: theme.textTheme.bodySmall,
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => SizedBox(width: 16.w),
        itemCount: projects.length,
      ),
    );
  }
}

class _AvailableProjectsGrid extends StatelessWidget {
  final List<ProjectModel> projects;

  const _AvailableProjectsGrid({required this.projects});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardTheme = theme.cardTheme;
    final colorScheme = theme.colorScheme;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        mainAxisExtent: 260.h,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        return Card(
          elevation: cardTheme.elevation ?? 4,
          shape: cardTheme.shape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
          color: cardTheme.color ?? colorScheme.surface,
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.asset(
                  project.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: colorScheme.surfaceContainerHighest,
                      child: Icon(
                        Icons.image_not_supported,
                        color: colorScheme.onSurfaceVariant,
                        size: 48.sp,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      project.title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: 12.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: FilledButton.tonal(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          textStyle: theme.textTheme.labelLarge,
                        ),
                        child: const Text('عرض تفاصيل'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

