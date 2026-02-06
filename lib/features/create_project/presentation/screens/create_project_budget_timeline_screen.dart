import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../controllers/create_project_controller.dart';
import '../widgets/create_project_dropdown_field.dart';
import '../widgets/create_project_header.dart';
import '../widgets/create_project_primary_button.dart';
import '../widgets/create_project_progress_indicator.dart';
import '../widgets/create_project_section_label.dart';
import '../widgets/create_project_secondary_button.dart';
import '../widgets/create_project_text_field.dart';
import 'create_project_upload_summary_screen.dart';

class CreateProjectBudgetTimelineScreen extends StatefulWidget {
  final CreateProjectController controller;

  const CreateProjectBudgetTimelineScreen({
    super.key,
    required this.controller,
  });

  @override
  State<CreateProjectBudgetTimelineScreen> createState() =>
      _CreateProjectBudgetTimelineScreenState();
}

class _CreateProjectBudgetTimelineScreenState
    extends State<CreateProjectBudgetTimelineScreen> {
  late final TextEditingController customBudgetController;
  bool _isSyncingBudgetText = false;

  @override
  void initState() {
    super.initState();
    customBudgetController = TextEditingController(
      text: _formatBudgetValue(widget.controller.customBudgetAmount),
    );
    widget.controller.addListener(_handleControllerUpdate);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleControllerUpdate);
    customBudgetController.dispose();
    super.dispose();
  }

  void _handleControllerUpdate() {
    _syncBudgetText(_formatBudgetValue(widget.controller.customBudgetAmount));
  }

  void _syncBudgetText(String value) {
    if (customBudgetController.text == value) return;
    _isSyncingBudgetText = true;
    customBudgetController.value = customBudgetController.value.copyWith(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
    _isSyncingBudgetText = false;
  }

  void _handleCustomBudgetChanged(String value) {
    if (_isSyncingBudgetText) return;
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    final parsed = digits.isEmpty ? null : int.tryParse(digits);
    widget.controller.updateCustomBudgetAmount(parsed);
  }

  String _formatBudgetValue(int? amount) {
    if (amount == null) return '';
    final digits = amount.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      final positionFromEnd = digits.length - i;
      buffer.write(digits[i]);
      if (positionFromEnd > 1 && positionFromEnd % 3 == 1) {
        buffer.write(',');
      }
    }
    return buffer.toString();
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
                      currentStep: 3,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'الميزانية والجدول الزمني',
                      textAlign: TextAlign.right,
                      style: AppTextStyles.sectionTitle,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'حدد ميزانيتك والمدة الزمنية المتوقعة للمشروع',
                      textAlign: TextAlign.right,
                      style: AppTextStyles.caption12,
                    ),
                    SizedBox(height: 20.h),
                    const CreateProjectSectionLabel(
                      text: 'نطاق الميزانية',
                      isRequired: true,
                    ),
                    SizedBox(height: 8.h),
                    CreateProjectDropdownField(
                      hintText: 'اختر نطاق ميزانيتك',
                      value: widget.controller.selectedBudgetRange,
                      items: widget.controller.budgetRanges,
                      onChanged: widget.controller.updateBudgetRange,
                    ),
                    if (widget.controller.isCustomBudgetSelected) ...[
                      SizedBox(height: 12.h),
                      CreateProjectTextField(
                        controller: customBudgetController,
                        hintText: 'أدخل المبلغ',
                        onChanged: _handleCustomBudgetChanged,
                        keyboardType: TextInputType.number,
                        inputFormatters: const [_BudgetInputFormatter()],
                        suffixText: 'ريال',
                      ),
                    ],
                    SizedBox(height: 8.h),
                    Text(
                      'الميزانية تقريبية وقد تختلف حسب العروض المقدمة',
                      textAlign: TextAlign.right,
                      style: AppTextStyles.caption12,
                    ),
                    SizedBox(height: 18.h),
                    const CreateProjectSectionLabel(
                      text: 'المدة الزمنية المتوقعة',
                      isRequired: true,
                    ),
                    SizedBox(height: 8.h),
                    CreateProjectDropdownField(
                      hintText: 'اختر المده المناسبه لمشروعك',
                      value: widget.controller.selectedTimeline,
                      items: widget.controller.timelines,
                      onChanged: widget.controller.updateTimeline,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'الجدول الزمني قابل للتعديل بالاتفاق مع المقاول',
                      textAlign: TextAlign.right,
                      style: AppTextStyles.caption12,
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      children: [
                        Expanded(
                          child: CreateProjectSecondaryButton(
                            label: 'السابق',
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: CreateProjectPrimaryButton(
                            label: 'التالي',
                            onPressed: widget.controller.isStep3Valid
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            CreateProjectUploadSummaryScreen(
                                          controller: widget.controller,
                                        ),
                                      ),
                                    );
                                  }
                                : null,
                          ),
                        ),
                      ],
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

class _BudgetInputFormatter extends TextInputFormatter {
  const _BudgetInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final rawDigits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (rawDigits.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    final formatted = _formatDigits(rawDigits);
    final digitsBeforeCursor = _countDigitsBeforeCursor(newValue);
    final cursorPosition =
        _calculateCursorPosition(formatted, digitsBeforeCursor);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }

  static String _formatDigits(String digits) {
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      final positionFromEnd = digits.length - i;
      buffer.write(digits[i]);
      if (positionFromEnd > 1 && positionFromEnd % 3 == 1) {
        buffer.write(',');
      }
    }
    return buffer.toString();
  }

  static int _countDigitsBeforeCursor(TextEditingValue value) {
    final selectionIndex = value.selection.baseOffset;
    if (selectionIndex <= 0) return 0;
    final limit = selectionIndex.clamp(0, value.text.length);
    var digits = 0;
    for (var i = 0; i < limit; i++) {
      if (value.text[i].contains(RegExp(r'[0-9]'))) {
        digits++;
      }
    }
    return digits;
  }

  static int _calculateCursorPosition(String formatted, int digitsBeforeCursor) {
    var digitsSeen = 0;
    for (var i = 0; i < formatted.length; i++) {
      if (formatted[i].contains(RegExp(r'[0-9]'))) {
        digitsSeen++;
      }
      if (digitsSeen >= digitsBeforeCursor) {
        return i + 1;
      }
    }
    return formatted.length;
  }
}

