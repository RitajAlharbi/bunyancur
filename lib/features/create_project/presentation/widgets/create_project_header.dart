import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class CreateProjectHeader extends StatelessWidget {
  final String title;

  const CreateProjectHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.orange900, size: 22.sp),
          onPressed: () => Navigator.maybePop(context),
        ),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.title,
          ),
        ),
        SizedBox(width: 40.w),
      ],
    );
  }
}
