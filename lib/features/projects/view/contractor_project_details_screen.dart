import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../models/project_model.dart';
import '../controller/contractor_project_details_controller.dart';
import 'widgets/map_preview_section.dart';

class ContractorProjectDetailsScreen extends StatelessWidget {
  const ContractorProjectDetailsScreen({super.key, required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ContractorProjectDetailsController(project: project),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppColor.white,
          body: SafeArea(
            child: Consumer<ContractorProjectDetailsController>(
              builder: (context, controller, _) {
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            HeroHeader(project: project),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w)
                                  .copyWith(top: 20.h, bottom: 24.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  InfoGridCard(project: project),
                                  SizedBox(height: 20.h),
                                  DescriptionCard(project: project),
                                  SizedBox(height: 20.h),
                                  GalleryGrid(project: project),
                                  SizedBox(height: 20.h),
                                  MapPreviewSection(
                                    location: project.mapLocation,
                                    projectImagePath: project.imagePath,
                                  ),
                                  SizedBox(height: 100.h),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 24.h),
                      child: PrimaryActionButton(
                        onPressed: () => controller.onSubmitOffer(context),
                      ),
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

class HeroHeader extends StatelessWidget {
  const HeroHeader({super.key, required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(28.r),
            bottomRight: Radius.circular(28.r),
          ),
          child: SizedBox(
            height: 280.h,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                project.imagePath.startsWith('http') ||
                        project.imagePath.startsWith('https')
                    ? Image.network(
                        project.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _placeholder(context),
                      )
                    : Image.asset(
                        project.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _placeholder(context),
                      ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(28.r),
                      bottomRight: Radius.circular(28.r),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.3),
                        Colors.black.withValues(alpha: 0.7),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 16.h,
          right: 16.w,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back,
                size: 24.sp,
                color: AppColor.orange900,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                project.title,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontFamily: 'Cairo',
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Icon(Icons.location_on_outlined,
                      size: 18.sp, color: Colors.white70),
                  SizedBox(width: 6.w),
                  Text(
                    project.city ?? '—',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white70,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Icon(Icons.calendar_today_outlined,
                      size: 18.sp, color: Colors.white70),
                  SizedBox(width: 6.w),
                  Text(
                    project.date ?? '—',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white70,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _placeholder(BuildContext context) => Container(
        height: 280.h,
        width: double.infinity,
        color: AppColor.grey200,
        child: Icon(Icons.image_not_supported,
            color: AppColor.grey400, size: 48.sp),
      );
}

class InfoGridCard extends StatelessWidget {
  const InfoGridCard({super.key, required this.project});

  final ProjectModel project;

  static const double _radius = 20;
  static const double _padding = 16;

  @override
  Widget build(BuildContext context) {
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
        children: [
          Row(
            children: [
              Icon(Icons.home_rounded, size: 22.sp, color: AppColor.orange900),
              SizedBox(width: 8.w),
              Text(
                'معلومات المشروع',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.orange900,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _GridItem(
                        label: 'نوع المشروع',
                        value: project.projectType ?? '—'),
                    SizedBox(height: 12.h),
                    _GridItem(label: 'المساحة', value: project.area ?? '—'),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _GridItem(
                        label: 'الميزانية',
                        value: project.budget ?? '—'),
                    SizedBox(height: 12.h),
                    _GridItem(
                        label: 'المدة الزمنية',
                        value: project.duration ?? '—'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            height: 1,
            color: AppColor.grey200,
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Icon(Icons.chat_bubble_outline,
                  size: 20.sp, color: AppColor.orange900),
              SizedBox(width: 8.w),
              Text(
                'العميل: ${project.clientName.isNotEmpty ? project.clientName : '—'}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.grey700,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GridItem extends StatelessWidget {
  const _GridItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.grey600,
            fontFamily: 'Cairo',
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: AppColor.black,
            fontFamily: 'Cairo',
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}

class DescriptionCard extends StatelessWidget {
  const DescriptionCard({super.key, required this.project});

  final ProjectModel project;

  static const double _radius = 20;
  static const double _padding = 16;

  @override
  Widget build(BuildContext context) {
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
        children: [
          Text(
            'وصف المشروع',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColor.orange900,
              fontFamily: 'Cairo',
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            project.description ?? '—',
            style: TextStyle(
              fontSize: 14.sp,
              height: 1.6,
              color: AppColor.grey700,
              fontFamily: 'Cairo',
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}

class GalleryGrid extends StatelessWidget {
  const GalleryGrid({super.key, required this.project});

  final ProjectModel project;

  static const double _radius = 20;
  static const double _padding = 16;
  static const double _imageRadius = 12;

  @override
  Widget build(BuildContext context) {
    final images = project.galleryImagePaths;
    final count = images.length;
    final displayList = count >= 4
        ? images.take(4).toList()
        : [
            ...images,
            ...List.filled(4 - count, ''),
          ];

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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.visibility_outlined,
                      size: 22.sp, color: AppColor.orange900),
                  SizedBox(width: 8.w),
                  Text(
                    'معرض الصور',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColor.orange900,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColor.grey100,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Text(
                  '$count صور',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColor.grey700,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 180.h,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 1,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                final path = displayList[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(_imageRadius.r),
                  child: path.isEmpty
                      ? Container(
                          color: AppColor.grey200,
                          child: Icon(Icons.image,
                              color: AppColor.grey400, size: 32.sp),
                        )
                      : (path.startsWith('http') || path.startsWith('https')
                          ? Image.network(path,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => _placeholder())
                          : Image.asset(path,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => _placeholder())),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() => Container(
        color: AppColor.grey200,
        child: Icon(Icons.image_not_supported,
            color: AppColor.grey400, size: 32.sp),
      );
}

class PrimaryActionButton extends StatelessWidget {
  const PrimaryActionButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: Material(
        color: AppColor.orange900,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16.r),
          child: Center(
            child: Text(
              'تقديم عرض',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: AppColor.white,
                fontFamily: 'Cairo',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
