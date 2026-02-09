import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../model/attachment_model.dart';

class AttachmentsSection extends StatelessWidget {
  final List<AttachmentModel> attachments;

  const AttachmentsSection({super.key, required this.attachments});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Icon(Icons.attach_file, size: 20.sp, color: AppColor.orange900),
                SizedBox(width: 8.w),
                Text(
                  'المرفقات',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColor.orange900,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ),
          ...attachments.asMap().entries.map((entry) {
            final index = entry.key;
            final attachment = entry.value;
            final isLast = index == attachments.length - 1;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
                  child: Row(
                    children: [
                      Icon(
                        Icons.description_outlined,
                        size: 22.sp,
                        color: AppColor.grey700,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          attachment.fileName,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColor.grey700,
                            fontFamily: 'Cairo',
                          ),
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColor.grey200,
                    indent: 16.w + 22.w + 12.w,
                    endIndent: 16.w,
                  ),
              ],
            );
          }),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}
