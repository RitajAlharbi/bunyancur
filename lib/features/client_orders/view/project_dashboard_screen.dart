import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../model/stage_vm.dart';

class ProjectDashboardScreen extends StatelessWidget {
  final String projectName;
  final double progressPercent;
  final List<StageVM> stages;

  const ProjectDashboardScreen({
    super.key,
    required this.projectName,
    required this.progressPercent,
    required this.stages,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_forward, color: AppColor.orange900),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'لوحة المتابعة',
            textAlign: TextAlign.center,
            style: AppTextStyles.title.copyWith(fontSize: 22.sp),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 24.h),
          child: Column(
            children: [
              _buildProgressRing(),
              SizedBox(height: 16.h),
              Text(
                projectName,
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(
                  fontSize: 18.sp,
                  color: const Color(0xFF354152),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 24.h),
              _buildTimeline(context),
              SizedBox(height: 24.h),
              _buildPaymentStagesButton(context),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressRing() {
    return SizedBox(
      width: 160.w,
      height: 160.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 160.w,
            height: 160.h,
            child: CircularProgressIndicator(
              value: (progressPercent / 100).clamp(0.0, 1.0),
              strokeWidth: 12.w,
              backgroundColor: const Color(0xFFEBEBEF),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
            ),
          ),
          Text(
            '${progressPercent.toInt()}%',
            style: AppTextStyles.body.copyWith(
              fontSize: 20.sp,
              color: const Color(0xFF121217),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stages.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final stage = stages[index];
        final isLast = index == stages.length - 1;
        return Row(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TimelineIndicator(stage: stage, isLast: isLast),
            SizedBox(width: 16.w),
            Expanded(
              child: _StageCard(stage: stage),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPaymentStagesButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: FilledButton(
        onPressed: () {
          // TODO: navigation placeholder
        },
        style: FilledButton.styleFrom(
          backgroundColor: AppColor.orange900,
          foregroundColor: AppColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
        child: Text(
          'عرض مراحل الدفع',
          style: AppTextStyles.body.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColor.white,
          ),
        ),
      ),
    );
  }
}

class _StageCard extends StatelessWidget {
  final StageVM stage;

  const _StageCard({required this.stage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: ShapeDecoration(
        color: const Color(0xFFF9FAFB),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.7, color: Color(0xFFF2F4F6)),
          borderRadius: BorderRadius.circular(14.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  stage.title,
                  style: AppTextStyles.body.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF101727),
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              _StatusChip(status: stage.status),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Icon(Icons.calendar_today_outlined, size: 16.r, color: AppColor.grey500),
              SizedBox(width: 6.w),
              Text(
                stage.dateText,
                style: AppTextStyles.body.copyWith(
                  fontSize: 14.sp,
                  color: const Color(0xFF697282),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            'الوقت المتبقي: ${stage.remainingDays} يوم',
            textAlign: TextAlign.right,
            style: AppTextStyles.body.copyWith(
              fontSize: 14.sp,
              color: const Color(0xFF495565),
            ),
          ),
          SizedBox(height: 12.h),
          OutlinedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.description_outlined, size: 16.r, color: AppColor.black),
            label: Text(
              stage.actionText,
              style: AppTextStyles.body.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColor.black,
              ),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColor.white,
              side: const BorderSide(width: 0.7, color: Color(0xFFD0D5DB)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 8.h),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final StageStatus status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    String label;
    Color bgColor;
    Color borderColor;
    Color textColor;

    switch (status) {
      case StageStatus.completed:
        label = 'مكتمل';
        bgColor = const Color(0xFFE8F5E9);
        borderColor = const Color(0xFF4CAF50);
        textColor = const Color(0xFF4CAF50);
        break;
      case StageStatus.inProgress:
        label = 'قيد التنفيذ';
        bgColor = const Color(0xFFFFF9E6);
        borderColor = const Color(0xFFE0A72E);
        textColor = const Color(0xFFE0A72E);
        break;
      case StageStatus.waiting:
        label = 'قيد الانتظار';
        bgColor = const Color(0xFFF5F5F5);
        borderColor = const Color(0xFFD9D9D9);
        textColor = const Color(0xFF9E9E9E);
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: ShapeDecoration(
        color: bgColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.7, color: borderColor),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption12.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _TimelineIndicator extends StatelessWidget {
  final StageVM stage;
  final bool isLast;

  const _TimelineIndicator({required this.stage, required this.isLast});

  @override
  Widget build(BuildContext context) {
    Color borderColor;
    switch (stage.status) {
      case StageStatus.completed:
        borderColor = const Color(0xFF4CAF50);
        break;
      case StageStatus.inProgress:
        borderColor = const Color(0xFFE0A72E);
        break;
      case StageStatus.waiting:
        borderColor = const Color(0xFFD9D9D9);
        break;
    }

    return SizedBox(
      width: 24.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 24.w,
            height: 24.h,
            decoration: ShapeDecoration(
              color: AppColor.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 3.5, color: borderColor),
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: stage.status == StageStatus.completed
                ? Icon(Icons.check, size: 14.r, color: borderColor)
                : null,
          ),
          if (!isLast)
            Container(
              width: 2.w,
              height: 155.h,
              margin: EdgeInsets.only(top: 4.h),
              decoration: const BoxDecoration(color: Color(0xFFE0E0E0)),
            ),
        ],
      ),
    );
  }
}
