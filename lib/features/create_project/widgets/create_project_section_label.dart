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
    if (!isRequired) {
      return Text(text, style: AppTextStyles.body);
    }

    return RichText(
      text: TextSpan(
        style: AppTextStyles.body,
        children: [
          TextSpan(text: text),
          TextSpan(
            text: ' *',
            style: AppTextStyles.body.copyWith(
              color: AppColor.orange900,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.right,
    );
  }
}
