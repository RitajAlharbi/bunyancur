import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_bottom_nav.dart';
import '../../../market/views/market_screen.dart';
import '../../../projects/available_projects/view/available_projects_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Notifications and Favorites
                    Row(
                      children: [
                        // Notifications Button
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
                        // Favorites Button
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
                    // User Info
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
                    // Avatar
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

              // Search Bar
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
                        colorFilter:
                            ColorFilter.mode(AppColor.grey400, BlendMode.srcIn),
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
                        colorFilter:
                            ColorFilter.mode(AppColor.grey400, BlendMode.srcIn),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              // Services Section
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

              // Services Cards
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
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // Filter Tabs
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: _FilterTab(
                        label: 'المنتجات',
                        isActive: false,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _FilterTab(
                        label: 'المصمم',
                        isActive: false,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _FilterTab(
                        label: 'المقاول',
                        isActive: false,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _FilterTab(
                        label: 'الكل',
                        isActive: true,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // Recommendations Section
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

              // Recommendations Cards
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _CompanyCard(
                            companyName: 'شركة بصمة للمقاولات',
                            location: 'الرياض',
                            rating: 4.7,
                            imageUrl: 'assets/images/Rectangle (2).png',
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: _CompanyCard(
                            companyName: 'شركة الفا للتصميم',
                            location: 'الخرج',
                            rating: 4.2,
                            imageUrl: 'assets/images/Rectangle (1).png',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 90.h), // Space for bottom navigation
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const AvailableProjectsPage(),
              ),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MarketScreen()),
            );
          }
        },
      ),
    );
  }
}

// Service Card Widget
class _ServiceCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const _ServiceCard({
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  child:
                      Icon(Icons.image, size: 48.sp, color: AppColor.grey400),
                );
              },
            ),
          ),
          // Gradient Overlay
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
          // Title
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
    );
  }
}

// Filter Tab Widget
class _FilterTab extends StatelessWidget {
  final String label;
  final bool isActive;

  const _FilterTab({
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38.h,
      decoration: BoxDecoration(
        color: isActive ? AppColor.orange900 : Colors.transparent,
        border: Border.all(
          color: AppColor.orange900,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Center(
        child: Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: 14.sp,
            color: isActive ? Colors.white : AppColor.orange900,
          ),
        ),
      ),
    );
  }
}

// Company Card Widget
class _CompanyCard extends StatelessWidget {
  final String companyName;
  final String location;
  final double rating;
  final String? imageUrl;

  const _CompanyCard({
    required this.companyName,
    required this.location,
    required this.rating,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.w,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 60,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Image with Rating
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: imageUrl != null
                    ? Image.asset(
                        imageUrl!,
                        width: double.infinity,
                        height: 154.h,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: 154.h,
                            decoration: BoxDecoration(
                              color: AppColor.grey200,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Icon(Icons.business,
                                size: 48.sp, color: AppColor.grey400),
                          );
                        },
                      )
                    : Container(
                        width: double.infinity,
                        height: 154.h,
                        decoration: BoxDecoration(
                          color: AppColor.grey200,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Icon(Icons.business,
                            size: 48.sp, color: AppColor.grey400),
                      ),
              ),
              // Rating Badge
              Positioned(
                top: 12.h,
                left: 12.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Color(0xffF0F0F0),
                    borderRadius: BorderRadius.circular(100.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 100,
                        offset: const Offset(0, 20),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, size: 10.sp, color: AppColor.orange900),
                      SizedBox(width: 4.w),
                      Text(
                        rating.toString(),
                        style: GoogleFonts.cairo(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColor.orange900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          // Company Name
          Text(
            companyName,
            style: GoogleFonts.cairo(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColor.orange900,
            ),
            textAlign: TextAlign.right,
          ),
          // Location
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: SvgPicture.asset(
                    'assets/icons/Heart.svg',
                    width: 20.w,
                    height: 20.h,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  location,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: GoogleFonts.cairo(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColor.grey700,
                  ),
                ),
              ),
            ],
          ),
          // Favorite Button
        ],
      ),
    );
  }
}

