import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../models/project_model.dart';

class AvailableProjectCard extends StatelessWidget {
  final ProjectModel project;
  final VoidCallback? onViewDetails;

  const AvailableProjectCard({
    super.key,
    required this.project,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Padding(
          padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: _ProjectImage(
                  imagePath: project.imagePath,
                  width: double.infinity,
                  height: 154.h,
                ),
              ),
              SizedBox(height: 10.h),
              Flexible(
                child: Text(
                  project.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Cairo',
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (project.clientName.isNotEmpty) ...[
                SizedBox(height: 4.h),
                Text(
                  project.clientName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.grey600,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Cairo',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              SizedBox(height: 10.h),
              SizedBox(
                height: 36.h,
                child: Center(
                  child: Material(
                    color: AppColor.orange900,
                    borderRadius: BorderRadius.circular(24.r),
                    child: InkWell(
                      onTap: onViewDetails,
                      borderRadius: BorderRadius.circular(24.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'عرض التفاصيل',
                          style: TextStyle(
                            color: AppColor.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectImage extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;

  const _ProjectImage({
    required this.imagePath,
    required this.width,
    required this.height,
  });

  static Widget _placeholder(double w, double h) => Container(
        width: w,
        height: h,
        color: AppColor.grey200,
        child: Icon(
          Icons.image_not_supported,
          color: AppColor.grey400,
          size: 48.sp,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final isNetwork = imagePath.startsWith('http://') ||
        imagePath.startsWith('https://');
    return SizedBox(
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
              errorBuilder: (_, __, ___) => _placeholder(width, height),
            ),
    );
  }
}
