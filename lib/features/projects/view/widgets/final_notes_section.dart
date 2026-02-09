import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class FinalNotesSection extends StatelessWidget {
  final List<String> notes;

  const FinalNotesSection({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                Icons.description,
                size: 20.sp,
                color: AppColor.orange900,
              ),
              SizedBox(width: 8.w),
              Text(
                'الملاحظات النهائية',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...notes.asMap().entries.map((entry) {
            final index = entry.key;
            final note = entry.value;
            return Padding(
              padding: EdgeInsets.only(bottom: index < notes.length - 1 ? 8.h : 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 18.sp,
                    color: AppColor.statusCompletedText,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      note,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black,
                        fontFamily: 'Cairo',
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
