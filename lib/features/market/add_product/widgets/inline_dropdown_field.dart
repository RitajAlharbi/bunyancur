import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class InlineDropdownField extends StatefulWidget {
  final String hintText;
  final String? value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  const InlineDropdownField({
    super.key,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.value,
  });

  @override
  State<InlineDropdownField> createState() => _InlineDropdownFieldState();
}

class _InlineDropdownFieldState extends State<InlineDropdownField>
    with TickerProviderStateMixin {
  bool isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void _selectItem(String value) {
    widget.onChanged(value);
    setState(() {
      isExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final displayText =
        widget.value?.isNotEmpty == true ? widget.value! : widget.hintText;
    final displayStyle = widget.value?.isNotEmpty == true
        ? AppTextStyles.body
        : AppTextStyles.body.copyWith(color: AppColor.grey400);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _toggleExpanded,
          child: Container(
            width: double.infinity,
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            decoration: BoxDecoration(
              color: AppColor.grey100,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColor.grey200),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      displayText,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: displayStyle,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: SvgPicture.asset(
                    'assets/icons/Icondown.svg',
                    width: 14.w,
                    height: 14.h,
                    colorFilter: const ColorFilter.mode(
                      AppColor.grey500,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: AlignmentDirectional.topCenter,
          child: isExpanded
              ? Container(
                  width: double.infinity,
                  margin: EdgeInsetsDirectional.only(top: 8.h),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColor.grey200),
                  ),
                  child: Column(
                    children: List.generate(widget.items.length, (index) {
                      final item = widget.items[index];
                      final isLast = index == widget.items.length - 1;
                      return InkWell(
                        onTap: () => _selectItem(item),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 16.w,
                                vertical: 12.h,
                              ),
                              child: Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child: Text(
                                  item,
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                  style: AppTextStyles.body,
                                ),
                              ),
                            ),
                            if (!isLast)
                              Divider(
                                height: 1.h,
                                color: AppColor.grey200,
                              ),
                          ],
                        ),
                      );
                    }),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
