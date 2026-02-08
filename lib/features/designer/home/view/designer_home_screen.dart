import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_bottom_nav.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../market/views/market_screen.dart';
import '../../../projects/available_projects/view/available_projects_page.dart';
import '../controller/designer_home_controller.dart';
import 'widgets/designer_home_header.dart';
import 'widgets/designer_horizontal_cards.dart';
import 'widgets/designer_search_bar.dart';
import 'widgets/designer_section_header.dart';

class DesignerHomeScreen extends StatefulWidget {
  const DesignerHomeScreen({super.key});

  @override
  State<DesignerHomeScreen> createState() => _DesignerHomeScreenState();
}

class _DesignerHomeScreenState extends State<DesignerHomeScreen> {
  late final DesignerHomeController controller;

  @override
  void initState() {
    super.initState();
    controller = DesignerHomeController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DesignerHomeScreen()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AvailableProjectsPage()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MarketScreen()),
      );
    } else if (index == 3 || index == 4) {
      // Placeholder for future tabs; stay on designer home for now
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DesignerHomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const DesignerHomeHeader(),
                SizedBox(height: 16.h),
                const DesignerSearchBar(),
                SizedBox(height: 18.h),
                DesignerSectionHeader(
                  title: 'مشاريعي الحالية',
                  actionText: 'مشاهدة الكل',
                ),
                SizedBox(height: 12.h),
                DesignerHorizontalCards(list: controller.currentProjects),
                SizedBox(height: 18.h),
                DesignerSectionHeader(
                  title: 'المشاريع المتاحة',
                  actionText: 'مشاهدة الكل',
                ),
                SizedBox(height: 12.h),
                DesignerHorizontalCards(list: controller.availableProjects),
                SizedBox(height: 90.h),
              ],
            ),
          ),
        ),
        bottomNavigationBar: AppBottomNav(
          currentIndex: 0,
          onTap: _onNavTap,
        ),
      ),
    );
  }
}
