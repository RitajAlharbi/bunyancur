import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../controllers/create_project_controller.dart';
import '../widgets/create_project_header.dart';
import '../widgets/create_project_primary_button.dart';
import '../widgets/create_project_progress_indicator.dart';
import '../widgets/create_project_summary_row.dart';
import '../widgets/create_project_upload_area.dart';

class CreateProjectUploadSummaryScreen extends StatefulWidget {
  final CreateProjectController controller;

  const CreateProjectUploadSummaryScreen({
    super.key,
    required this.controller,
  });

  @override
  State<CreateProjectUploadSummaryScreen> createState() =>
      _CreateProjectUploadSummaryScreenState();
}

class _CreateProjectUploadSummaryScreenState
    extends State<CreateProjectUploadSummaryScreen> {
  @override
  void initState() {
    super.initState();
    widget.controller.loadRecommendedProviders(
      type: 'contractor',
      city: widget.controller.data.city,
    );
  }

  Future<void> _handleSubmit() async {
    final projectId = await widget.controller.submitProjectAndSendRequests();
    if (!mounted) return;

    if (projectId != null) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      return;
    }

    final message = widget.controller.errorMessage ?? 'تعذر إنشاء المشروع';
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
          child: AnimatedBuilder(
            animation: widget.controller,
            builder: (context, _) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 24.w,
                  right: 24.w,
                  top: 12.h,
                  bottom: 24.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CreateProjectHeader(title: 'إنشاء مشروع جديد'),
                    SizedBox(height: 12.h),
                    const CreateProjectProgressIndicator(
                      totalSteps: 4,
                      currentStep: 4,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'ارفع ملفات مشروعك وصور المخططات',
                      textAlign: TextAlign.right,
                      style: AppTextStyles.sectionTitle,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'أضف صور وملفات تساعد المقاولين على فهم متطلباتك',
                      textAlign: TextAlign.right,
                      style: AppTextStyles.caption12,
                    ),
                    SizedBox(height: 20.h),
                    CreateProjectUploadArea(
                      title: 'صور المشروع',
                      titleIcon: Icons.image_outlined,
                      actionText: 'انقر لرفع الصور',
                      allowedTypesText: '(حتى 10 صور) JPG, PNG',
                      isEmpty: widget.controller.projectImages.isEmpty,
                      onTap: widget.controller.pickProjectImages,
                      content: _SelectedImagesGrid(controller: widget.controller),
                    ),
                    SizedBox(height: 16.h),
                    CreateProjectUploadArea(
                      title: 'المخططات والملفات',
                      titleIcon: Icons.description_outlined,
                      actionText: 'انقر لرفع المخططات',
                      allowedTypesText: 'PDF, DWG, JPG',
                      isEmpty: widget.controller.projectFiles.isEmpty,
                      onTap: widget.controller.pickProjectFiles,
                      content: _SelectedFilesList(controller: widget.controller),
                    ),
                    SizedBox(height: 20.h),
                    _SummaryCard(controller: widget.controller),
                    SizedBox(height: 20.h),
                    _ProvidersSection(controller: widget.controller),
                    if (widget.controller.errorMessage != null) ...[
                      SizedBox(height: 8.h),
                      Text(
                        widget.controller.errorMessage!,
                        textAlign: TextAlign.right,
                        style: AppTextStyles.caption12
                            .copyWith(color: AppColor.orange900),
                      ),
                    ],
                    SizedBox(height: 20.h),
                    if (widget.controller.isSubmitting)
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                    CreateProjectPrimaryButton(
                      label: widget.controller.isSubmitting
                          ? 'جاري إنشاء المشروع...'
                          : 'إنشاء المشروع',
                      onPressed: widget.controller.canSubmit && !widget.controller.isSubmitting
                          ? _handleSubmit
                          : null,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'بإنشاء المشروع، أنت توافق على شروط وأحكام المنصة',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.caption12,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ProvidersSection extends StatelessWidget {
  final CreateProjectController controller;

  const _ProvidersSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.grey100,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'مقاولون مقترحون',
            textAlign: TextAlign.right,
            style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 6.h),
          Text(
            'اختر المقاولين الذين تريد إرسال طلب الخدمة لهم (اختياري)',
            textAlign: TextAlign.right,
            style: AppTextStyles.caption12,
          ),
          SizedBox(height: 12.h),
          if (controller.isLoadingProviders)
            const Center(child: CircularProgressIndicator())
          else if (controller.recommendedProviders.isEmpty)
            Text(
              'لا توجد نتائج حالياً',
              textAlign: TextAlign.right,
              style: AppTextStyles.caption12,
            )
          else
            Column(
              children: controller.recommendedProviders.map((provider) {
                final selected =
                    controller.data.selectedProviderIds.contains(provider.id);
                return Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColor.grey200),
                  ),
                  child: CheckboxListTile(
                    value: selected,
                    onChanged: (_) =>
                        controller.toggleProviderSelection(provider.id),
                    side: BorderSide(color: AppColor.grey200),
                    activeColor: AppColor.orange900,
                    title: Text(
                      provider.displayName.isEmpty
                          ? 'مقاول بدون اسم'
                          : provider.displayName,
                      textAlign: TextAlign.right,
                      style: AppTextStyles.body,
                    ),
                    subtitle: Text(
                      '${provider.city} - ${provider.avgRating.toStringAsFixed(1)} (${provider.reviewsCount})',
                      textAlign: TextAlign.right,
                      style: AppTextStyles.caption12,
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}

class _SelectedImagesGrid extends StatelessWidget {
  final CreateProjectController controller;

  const _SelectedImagesGrid({required this.controller});

  @override
  Widget build(BuildContext context) {
    if (controller.projectImages.isEmpty) {
      return const SizedBox.shrink(key: ValueKey('empty-images'));
    }
    return Wrap(
      key: const ValueKey('images-grid'),
      spacing: 8.w,
      runSpacing: 8.h,
      children: List.generate(controller.projectImages.length, (index) {
        final image = controller.projectImages[index];
        return _UploadThumbnail(
          imagePath: image.path,
          onRemove: () => controller.removeProjectImageAt(index),
        );
      }),
    );
  }
}

class _UploadThumbnail extends StatelessWidget {
  final String imagePath;
  final VoidCallback onRemove;

  const _UploadThumbnail({
    required this.imagePath,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final image = kIsWeb
        ? Image.network(imagePath, fit: BoxFit.cover)
        : Image.file(File(imagePath), fit: BoxFit.cover);
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: SizedBox(
            width: 72.w,
            height: 72.w,
            child: image,
          ),
        ),
        Positioned(
          top: 4.h,
          right: 4.w,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: AppColor.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColor.grey200),
              ),
              child: Icon(
                Icons.close,
                size: 12.sp,
                color: AppColor.grey700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SelectedFilesList extends StatelessWidget {
  final CreateProjectController controller;

  const _SelectedFilesList({required this.controller});

  @override
  Widget build(BuildContext context) {
    if (controller.projectFiles.isEmpty) {
      return const SizedBox.shrink(key: ValueKey('empty-files'));
    }
    return Column(
      key: const ValueKey('files-list'),
      children: List.generate(controller.projectFiles.length, (index) {
        final file = controller.projectFiles[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: _UploadFileRow(
            fileName: file.name,
            onRemove: () => controller.removeProjectFileAt(index),
          ),
        );
      }),
    );
  }
}

class _UploadFileRow extends StatelessWidget {
  final String fileName;
  final VoidCallback onRemove;

  const _UploadFileRow({
    required this.fileName,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onRemove,
          child: Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              color: AppColor.grey200,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.close,
              size: 14.sp,
              color: AppColor.grey700,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            fileName,
            textAlign: TextAlign.right,
            style: AppTextStyles.body,
          ),
        ),
        Icon(
          Icons.insert_drive_file_outlined,
          size: 18.sp,
          color: AppColor.orange900,
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final CreateProjectController controller;

  const _SummaryCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.grey100,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.check_circle, color: AppColor.orange900, size: 18.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'ملخص المشروع',
                  textAlign: TextAlign.right,
                  style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          CreateProjectSummaryRow(
            label: 'اسم المشروع:',
            value: controller.summaryProjectName,
          ),
          SizedBox(height: 8.h),
          CreateProjectSummaryRow(
            label: 'نوع المشروع:',
            value: controller.summaryProjectType,
          ),
          SizedBox(height: 8.h),
          CreateProjectSummaryRow(
            label: 'المساحة:',
            value: controller.summaryProjectArea,
          ),
          SizedBox(height: 8.h),
          CreateProjectSummaryRow(
            label: 'الموقع:',
            value: controller.summaryLocation,
          ),
          SizedBox(height: 8.h),
          CreateProjectSummaryRow(
            label: 'الميزانية:',
            value: controller.summaryBudget,
          ),
          SizedBox(height: 8.h),
          CreateProjectSummaryRow(
            label: 'المدة:',
            value: controller.summaryTimeline,
          ),
        ],
      ),
    );
  }
}
