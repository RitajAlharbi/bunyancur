import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_bottom_nav.dart';
import '../../../core/routing/routes.dart';
import '../../create_project/view/create_project_screen.dart';
import '../controller/home_controller.dart';
import '../model/home_item_model.dart';
import 'widgets/filter_bar.dart';
import 'widgets/home_item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeController controller;

  @override
  void initState() {
    super.initState();
    controller = HomeController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<Widget> _buildRecommendationRows(List<HomeItemModel> items) {
    if (items.isEmpty) {
      return [const SizedBox.shrink()];
    }
    final rows = <Widget>[];
    for (var i = 0; i < items.length; i += 2) {
      final first = items[i];
      final second = i + 1 < items.length ? items[i + 1] : null;
      rows.add(
        Row(
          textDirection: TextDirection.rtl,
          children: [
            Expanded(child: HomeItemCard(item: first)),
            SizedBox(width: 16.w),
            Expanded(
              child: second != null ? HomeItemCard(item: second) : const SizedBox.shrink(),
            ),
          ],
        ),
      );
      if (i + 2 < items.length) {
        rows.add(SizedBox(height: 16.h));
      }
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColor.grey200),
                                shape: BoxShape.circle,
                              ),
                              child: Stack(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/notfication.svg',
                                    width: 24.w,
                                    height: 24.h,
                                  ),
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      width: 6.w,
                                      height: 6.h,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColor.grey200),
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/Heart.svg',
                                width: 24.w,
                                height: 24.h,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'مرحبا صالح 👋',
                                style: GoogleFonts.cairo(
                                  fontSize: 16.sp,
                                  color: AppColor.grey600,
                                ),
                              ),
                              Text(
                                'صالح محمد',
                                style: GoogleFonts.cairo(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.orange900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12.w),
                        CircleAvatar(
                          radius: 24.r,
                          backgroundColor: Colors.transparent,
                          child: Image.asset(
                            'assets/icons/avatar.png',
                            width: 40.w,
                            height: 40.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
                      decoration: BoxDecoration(
                        color: AppColor.grey100,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/Filter.svg',
                            width: 24.w,
                            height: 24.h,
                            colorFilter: ColorFilter.mode(
                              AppColor.grey400,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              'البحث',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.cairo(
                                fontSize: 14.sp,
                                color: AppColor.grey400,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          SvgPicture.asset(
                            'assets/icons/Search.svg',
                            width: 24.w,
                            height: 24.h,
                            colorFilter: ColorFilter.mode(
                              AppColor.grey400,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'مشاهدة الكل',
                            style: GoogleFonts.cairo(
                              fontSize: 14.sp,
                              color: AppColor.orange900,
                            ),
                          ),
                        ),
                        Text(
                          'الخدمات',
                          style: GoogleFonts.cairo(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColor.orange900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: _ServiceCard(
                            title: 'إنشاء طلب مصمم داخلي',
                            imageUrl: 'assets/images/service1.png',
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: _ServiceCard(
                            title: 'إنشاء طلب مقاول',
                            imageUrl: 'assets/images/service2.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                      builder: (_) => const CreateProjectScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: FilterBar(
                      selectedFilter: controller.selectedFilter,
                      onChanged: controller.selectFilter,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'توصياتنا',
                          style: GoogleFonts.cairo(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColor.orange900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children:
                          _buildRecommendationRows(controller.filteredRecommendations),
                    ),
                  ),
                  SizedBox(height: 90.h),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) return;
          if (index == 2) {
            Navigator.pushReplacementNamed(context, Routes.marketScreen);
            return;
          }
          if (index == 3) {
            Navigator.pushReplacementNamed(context, Routes.messagesScreen);
            return;
          }
          if (index == 1) {
            Navigator.pushReplacementNamed(context, Routes.clientOrdersScreen);
            return;
          }
          if (index == 4) {
            return;
          }
        },
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback? onTap;

  const _ServiceCard({
    required this.title,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 192.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24.r),
              child: Image.asset(
                imageUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColor.grey200,
                    child: Icon(
                      Icons.image,
                      size: 48.sp,
                      color: AppColor.grey400,
                    ),
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.3),
                    Colors.black.withValues(alpha: 0.7),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
            Positioned(
              bottom: 16.h,
              left: 18.w,
              right: 18.w,
              child: Text(
                textAlign: TextAlign.right,
                title,
                style: GoogleFonts.cairo(
                  fontSize: 12.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
