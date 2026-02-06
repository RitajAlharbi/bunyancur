import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';

class ProjectsPieChart extends StatelessWidget {
  final int completedCount;
  final int inProgressCount;
  final int pendingCount;

  const ProjectsPieChart({
    super.key,
    required this.completedCount,
    required this.inProgressCount,
    required this.pendingCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Text(
            'المشاريع',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColor.grey700,
              fontFamily: 'Cairo',
            ),
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: 180.w,
          height: 180.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(180.w, 180.h),
                painter: _PieChartPainter(
                  completed: completedCount,
                  inProgress: inProgressCount,
                  pending: pendingCount,
                ),
              ),
              _ChartLabels(
                completedCount: completedCount,
                inProgressCount: inProgressCount,
                pendingCount: pendingCount,
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        _Legend(
          completedCount: completedCount,
          inProgressCount: inProgressCount,
          pendingCount: pendingCount,
        ),
      ],
    );
  }
}

class _PieChartPainter extends CustomPainter {
  final int completed;
  final int inProgress;
  final int pending;

  _PieChartPainter({
    required this.completed,
    required this.inProgress,
    required this.pending,
  });

  int get _total => completed + inProgress + pending;

  @override
  void paint(Canvas canvas, Size size) {
    if (_total == 0) return;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Order: Completed (green, top-right), Pending (yellow, middle-left), In Progress (blue, bottom)
    double startAngle = -math.pi / 2; // Start from top
    final sweep1 = (completed / _total) * 2 * math.pi;
    final sweep2 = (pending / _total) * 2 * math.pi;
    final sweep3 = (inProgress / _total) * 2 * math.pi;

    final segments = [
      (sweep1, AppColor.statusCompletedBg),
      (sweep2, AppColor.statusPendingBg),
      (sweep3, AppColor.statusInProgressBg),
    ];

    for (final (sweep, color) in segments) {
      if (sweep <= 0) continue;
      final path = Path()
        ..moveTo(center.dx, center.dy)
        ..arcTo(rect, startAngle, sweep, false)
        ..close();
      canvas.drawPath(path, Paint()..color = color);
      startAngle += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant _PieChartPainter oldDelegate) {
    return oldDelegate.completed != completed ||
        oldDelegate.inProgress != inProgress ||
        oldDelegate.pending != pending;
  }
}

class _ChartLabels extends StatelessWidget {
  final int completedCount;
  final int inProgressCount;
  final int pendingCount;

  const _ChartLabels({
    required this.completedCount,
    required this.inProgressCount,
    required this.pendingCount,
  });

  int get _total => completedCount + inProgressCount + pendingCount;

  @override
  Widget build(BuildContext context) {
    final chartSize = 180.w;
    final center = chartSize / 2;
    final chartRadius = chartSize / 2;
    final labelRadius = chartRadius + 32.w;

    final total = _total;
    // When total is 0, use equal sweeps so labels sit at 120° apart
    final completedSweep = total > 0
        ? (completedCount / total) * 2 * math.pi
        : (2 * math.pi) / 3;
    final pendingSweep = total > 0
        ? (pendingCount / total) * 2 * math.pi
        : (2 * math.pi) / 3;
    final inProgressSweep = total > 0
        ? (inProgressCount / total) * 2 * math.pi
        : (2 * math.pi) / 3;

    double startAngle = -math.pi / 2;
    final completedAngle = startAngle + completedSweep / 2;
    final pendingAngle = startAngle + completedSweep + pendingSweep / 2;
    final inProgressAngle =
        startAngle + completedSweep + pendingSweep + inProgressSweep / 2;

    return Stack(
      children: [
        _segmentLabel(
          center: center,
          labelRadius: labelRadius,
          angle: completedAngle,
          text: 'مكتمل: $completedCount',
          textColor: AppColor.statusCompletedText,
          anchorDx: -35.w,
        ),
        _segmentLabel(
          center: center,
          labelRadius: labelRadius,
          angle: pendingAngle,
          text: 'انتظار الموافقة: $pendingCount',
          textColor: AppColor.statusPendingText,
          anchorDx: -70.w,
        ),
        _segmentLabel(
          center: center,
          labelRadius: labelRadius,
          angle: inProgressAngle,
          text: 'قيد التنفيذ: $inProgressCount',
          textColor: AppColor.statusInProgressText,
          anchorDx: -50.w,
        ),
      ],
    );
  }

  Widget _segmentLabel({
    required double center,
    required double labelRadius,
    required double angle,
    required String text,
    required Color textColor,
    required double anchorDx,
  }) {
    final left = center + labelRadius * math.cos(angle) + anchorDx;
    final top = center + labelRadius * math.sin(angle) - 8.h;
    return Positioned(
      left: left,
      top: top,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          color: textColor,
          fontFamily: 'Cairo',
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final int completedCount;
  final int inProgressCount;
  final int pendingCount;

  const _Legend({
    required this.completedCount,
    required this.inProgressCount,
    required this.pendingCount,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      fontFamily: 'Cairo',
    );
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _LegendItem(
            color: AppColor.statusCompletedBg,
            textColor: AppColor.statusCompletedText,
            label: 'مكتمل',
            style: style,
          ),
          SizedBox(width: 12.w),
          _LegendItem(
            color: AppColor.statusInProgressBg,
            textColor: AppColor.statusInProgressText,
            label: 'قيد التنفيذ',
            style: style,
          ),
          SizedBox(width: 12.w),
          _LegendItem(
            color: AppColor.statusPendingBg,
            textColor: AppColor.statusPendingText,
            label: 'انتظار الموافقة',
            style: style,
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String label;
  final TextStyle style;

  const _LegendItem({
    required this.color,
    required this.textColor,
    required this.label,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10.w,
          height: 10.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.zero,
          ),
        ),
        SizedBox(width: 6.w),
        Text(
          label,
          style: style.copyWith(color: textColor),
        ),
      ],
    );
  }
}
