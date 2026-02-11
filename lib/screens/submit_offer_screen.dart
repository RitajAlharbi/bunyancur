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
        appBar: _buildAppBar(context),
        body: SafeArea(
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
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'تقديم عرض',
        style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
              color: AppColor.primaryColor,
            ) ??
            AppTextStyles.title,
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_forward_ios,
          size: 18.sp,
          color: Theme.of(context).iconTheme.color,
        ),
        onPressed: () => Navigator.of(context).pop(),
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

class _AttachmentsSection extends StatelessWidget {
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
        _UploadArea(),
      ],
    );
  }
}

class _UploadArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
