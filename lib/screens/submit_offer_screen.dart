import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

class SubmitOfferScreen extends StatelessWidget {
  const SubmitOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Header(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _ProjectSummaryCard(
                        projectName: 'ترميم منزل قديم',
                        location: 'الخرج – حي الملز',
                        budget: 'أكثر من 500,000 ريال',
                        imageWidget: _buildProjectImagePlaceholder(context),
                      ),
                      SizedBox(height: 24.h),
                      _SectionTitle(title: 'تفاصيل العرض'),
                      SizedBox(height: 16.h),
                      _OfferDetailsForm(),
                      SizedBox(height: 24.h),
                      _AttachmentsSection(),
                      SizedBox(height: 32.h),
                      _SubmitButton(label: 'إرسال العرض'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectImagePlaceholder(BuildContext context) {
    return Container(
      width: 80.w,
      height: 80.h,
      decoration: BoxDecoration(
        color: AppColor.grey200,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Icon(
        Icons.home_rounded,
        size: 40.sp,
        color: AppColor.grey500,
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              color: AppColor.orange900,
              size: 24.sp,
            ),
          ),
          Expanded(
            child: Text(
              'تقديم عرض',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColor.orange900,
                fontFamily: 'Cairo',
              ),
            ),
          ),
          SizedBox(width: 48.w),
        ],
      ),
    );
  }
}

class _ProjectSummaryCard extends StatelessWidget {
  final String projectName;
  final String location;
  final String budget;
  final Widget imageWidget;

  const _ProjectSummaryCard({
    required this.projectName,
    required this.location,
    required this.budget,
    required this.imageWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.grey400.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ProjectInfoRow(
                  icon: Icons.folder_outlined,
                  label: 'اسم المشروع',
                  value: projectName,
                  valueStyle: AppTextStyles.body,
                ),
                SizedBox(height: 12.h),
                _ProjectInfoRow(
                  icon: Icons.location_on_outlined,
                  label: 'الموقع',
                  value: location,
                  valueStyle: AppTextStyles.body,
                ),
                SizedBox(height: 12.h),
                _ProjectInfoRow(
                  icon: Icons.account_balance_wallet_outlined,
                  label: 'الميزانية',
                  value: budget,
                  valueStyle: AppTextStyles.price,
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          imageWidget,
        ],
      ),
    );
  }
}

class _ProjectInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final TextStyle valueStyle;

  const _ProjectInfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18.sp, color: AppColor.grey500),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.caption12),
              SizedBox(height: 2.h),
              Text(value, style: valueStyle),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$title *',
      style: AppTextStyles.sectionTitle.copyWith(
        color: AppColor.grey700,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _OfferDetailsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _LabeledTextField(
          label: 'السعر المقترح',
          hint: 'أدخل السعر',
          suffix: 'ريال',
          required: true,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 16.h),
        _LabeledTextField(
          label: 'مدة التنفيذ',
          hint: 'أدخل المدة',
          suffix: 'يوم',
          required: true,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 16.h),
        _LabeledTextField(
          label: 'وصف العرض (الأعمال المطلوبة)',
          hint: 'اكتب وصفاً تفصيلياً للأعمال التي ستقوم بها.....',
          required: true,
          maxLines: 4,
        ),
      ],
    );
  }
}

class _LabeledTextField extends StatelessWidget {
  final String label;
  final String hint;
  final String? suffix;
  final bool required;
  final TextInputType? keyboardType;
  final int maxLines;

  const _LabeledTextField({
    required this.label,
    required this.hint,
    this.suffix,
    this.required = false,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          required ? '$label *' : label,
          style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8.h),
        TextField(
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.caption12.copyWith(
              color: AppColor.grey500,
            ),
            suffixText: suffix,
            suffixStyle: AppTextStyles.body.copyWith(
              color: AppColor.grey600,
            ),
            filled: true,
            fillColor: AppColor.grey100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: maxLines > 1 ? 12.h : 14.h,
            ),
          ),
          style: AppTextStyles.body,
        ),
      ],
    );
  }
}

/// حد أقصى لحجم الملف: 10 ميجابايت
const int _maxFileSizeBytes = 10 * 1024 * 1024;

/// امتدادات مسموحة: صور، PDF، DOC
const List<String> _allowedExtensions = [
  'jpg',
  'jpeg',
  'png',
  'gif',
  'webp',
  'pdf',
  'doc',
  'docx',
];

class _AttachmentsSection extends StatefulWidget {
  @override
  State<_AttachmentsSection> createState() => _AttachmentsSectionState();
}

class _AttachmentsSectionState extends State<_AttachmentsSection> {
  final List<PlatformFile> _files = [];

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: _allowedExtensions,
      allowMultiple: true,
    );
    if (result == null || result.files.isEmpty) return;
    final oversize = <String>[];
    for (final file in result.files) {
      if (file.size > _maxFileSizeBytes) {
        oversize.add(file.name);
      } else {
        setState(() => _files.add(file));
      }
    }
    if (oversize.isNotEmpty && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'الملفات التالية تتجاوز 10 ميجا: ${oversize.join(", ")}',
          ),
          backgroundColor: AppColor.orange900,
        ),
      );
    }
  }

  void _removeFile(int index) {
    setState(() => _files.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المرفقات (اختياري)',
          style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: _pickFiles,
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: AppColor.grey400,
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.cloud_upload_rounded,
                  size: 48.sp,
                  color: AppColor.primaryColor,
                ),
                SizedBox(height: 12.h),
                Text(
                  'اضغط لرفع ملف أو صورة',
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColor.grey700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'صور (حتى 10 ميجا) PDF, DOC',
                  style: AppTextStyles.caption12.copyWith(
                    color: AppColor.grey500,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_files.isNotEmpty) ...[
          SizedBox(height: 12.h),
          ...List.generate(_files.length, (index) {
            final file = _files[index];
            final sizeMb = (file.size / (1024 * 1024)).toStringAsFixed(2);
            return Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                children: [
                  Icon(Icons.insert_drive_file,
                      size: 20.sp, color: AppColor.orange900),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      '${file.name} ($sizeMb ميجا)',
                      style: AppTextStyles.caption12.copyWith(
                        color: AppColor.grey700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, size: 20.sp, color: AppColor.grey600),
                    onPressed: () => _removeFile(index),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            );
          }),
        ],
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final String label;

  const _SubmitButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          foregroundColor: AppColor.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.body.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColor.white,
          ),
        ),
      ),
    );
  }
}
