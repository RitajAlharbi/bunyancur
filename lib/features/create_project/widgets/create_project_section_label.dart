import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class CreateProjectSectionLabel extends StatelessWidget {
  final String text;
  final bool isRequired;

  const CreateProjectSectionLabel({
    super.key,
    required this.text,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (isRequired)
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Text(
              '*',
              style: AppTextStyles.body.copyWith(color: AppColor.orange900),
            ),
          ),
        Text(
          text,
          textAlign: TextAlign.right,
          style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
