import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../home/model/professional_vm.dart';

class ProfileHeaderCard extends StatelessWidget {
  final ProfessionalVm professional;
  final VoidCallback? onMessageTap;
  final VoidCallback? onArrowTap;

  const ProfileHeaderCard({
    super.key,
    required this.professional,
    this.onMessageTap,
    this.onArrowTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: ShapeDecoration(
        color: AppColor.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.53, color: AppColor.borderLight),
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: [
          BoxShadow(
            color: AppColor.shadowLight,
            blurRadius: 3,
            offset: const Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Center(child: _buildAvatar()),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      professional.displayName,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: AppTextStyles.body.copyWith(
                        color: AppColor.headingDark,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        professional.city ?? '—',
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: AppTextStyles.body.copyWith(
                          color: AppColor.secondaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(width: 4),
                      SvgPicture.asset(
                        'assets/icons/Icon6.svg',
                        width: 16,
                        height: 16,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      textDirection: TextDirection.rtl,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/Icon7.svg',
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '4.8',
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: AppTextStyles.body.copyWith(
                            color: AppColor.darkText,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          width: 1,
                          height: 24,
                          color: Colors.black.withValues(alpha: 0.10),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '156 تقييم',
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: AppTextStyles.caption12.copyWith(
                            color: AppColor.secondaryText,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: onMessageTap,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: ShapeDecoration(
                        color: AppColor.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1.59,
                            color: AppColor.orange900,
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          textDirection: TextDirection.rtl,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/Icon8.svg',
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'مراسلة',
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              style: AppTextStyles.body.copyWith(
                                color: AppColor.orange900,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (onArrowTap != null)
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: onArrowTap,
                    behavior: HitTestBehavior.opaque,
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/Icon5.svg',
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    final url = professional.logoUrl;
    if (url != null &&
        url.isNotEmpty &&
        (url.startsWith('http://') || url.startsWith('https://'))) {
      return CachedNetworkImage(
        imageUrl: url,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        imageBuilder: (context, imageProvider) => Container(
          width: 100,
          height: 100,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
            shadows: [
              BoxShadow(
                color: AppColor.shadowMedium,
                blurRadius: 4,
                offset: const Offset(0, 2),
                spreadRadius: -2,
              ),
              BoxShadow(
                color: AppColor.shadowMedium,
                blurRadius: 6,
                offset: const Offset(0, 4),
                spreadRadius: -1,
              ),
            ],
          ),
        ),
        placeholder: (_, __) => _buildFallbackAvatar(),
        errorWidget: (_, __, ___) => _buildFallbackAvatar(),
      );
    }
    return _buildFallbackAvatar();
  }

  Widget _buildFallbackAvatar() {
    final initial = professional.displayName.isNotEmpty
        ? professional.displayName.substring(0, 1).toUpperCase()
        : '?';
    return Container(
      width: 100,
      height: 100,
      decoration: ShapeDecoration(
        color: AppColor.grey200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        shadows: [
          BoxShadow(
            color: AppColor.shadowMedium,
            blurRadius: 4,
            offset: const Offset(0, 2),
            spreadRadius: -2,
          ),
        ],
      ),
      child: Center(
        child: Text(
          initial,
          style: AppTextStyles.sectionTitle.copyWith(
            color: AppColor.grey600,
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
