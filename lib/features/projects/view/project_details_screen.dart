import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../model/current_project_model.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final CurrentProjectModel project;

  const ProjectDetailsScreen({super.key, required this.project});

  static const routeName = '/projectDetails';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColor.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColor.orange900),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            project.title,
            style: TextStyle(
              color: AppColor.orange900,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'Cairo',
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: project.imagePath.startsWith('http')
                    ? Image.network(
                        project.imagePath,
                        height: 200.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _placeholder(),
                      )
                    : Image.asset(
                        project.imagePath,
                        height: 200.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _placeholder(),
                      ),
              ),
              SizedBox(height: 20.h),
              if (project.clientName.isNotEmpty)
                Text(
                  project.clientName,
                  style: TextStyle(
                    color: AppColor.grey700,
                    fontSize: 16.sp,
                    fontFamily: 'Cairo',
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _placeholder() => Container(
        height: 200.h,
        color: AppColor.grey200,
        child: Icon(Icons.image_not_supported, color: AppColor.grey400),
      );
}
