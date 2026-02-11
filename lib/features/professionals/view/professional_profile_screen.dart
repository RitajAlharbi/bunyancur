import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/routing/routes.dart';
import '../controller/professional_profile_controller.dart';
import '../../home/model/professional_vm.dart';
import 'widgets/profile_header_card.dart';
import 'widgets/about_card.dart';
import 'widgets/products_grid.dart';
import 'widgets/works_grid.dart';
import 'widgets/reviews_list.dart';

class ProfessionalProfileScreen extends StatefulWidget {
  final String professionalId;

  const ProfessionalProfileScreen({
    super.key,
    required this.professionalId,
  });

  @override
  State<ProfessionalProfileScreen> createState() =>
      _ProfessionalProfileScreenState();
}

class _ProfessionalProfileScreenState extends State<ProfessionalProfileScreen>
    with SingleTickerProviderStateMixin {
  late final ProfessionalProfileController controller;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    controller = ProfessionalProfileController();
    _tabController = TabController(length: 4, vsync: this);
    controller.loadProfessional(widget.professionalId);
  }

  @override
  void dispose() {
    _tabController.dispose();
    controller.dispose();
    super.dispose();
  }

  void _navigateToChat() {
    final pro = controller.professional;
    if (pro == null) return;
    Navigator.pushNamed(
      context,
      Routes.chatScreen,
      arguments: <String, String>{
        'threadId': pro.id,
        'displayName': pro.displayName,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              if (controller.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColor.orange900),
                );
              }
              if (controller.error != null) {
                return Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Center(
                    child: Text(
                      controller.error!,
                      style: AppTextStyles.body.copyWith(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              final pro = controller.professional;
              if (pro == null) {
                return Center(
                  child: Text(
                    'لم يتم العثور على الملف',
                    style: AppTextStyles.body.copyWith(color: AppColor.grey700),
                  ),
                );
              }
              return _buildContent(pro);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(ProfessionalVm pro) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
          child: ProfileHeaderCard(
            professional: pro,
            onMessageTap: _navigateToChat,
            onArrowTap: () => Navigator.of(context).pop(),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: _buildTabBar(),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildAboutTab(pro),
              _buildWorksTab(),
              _buildProductsTab(),
              _buildReviewsTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: 48,
      decoration: ShapeDecoration(
        color: AppColor.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        shadows: [
          BoxShadow(
            color: AppColor.shadowMedium,
            blurRadius: 2,
            offset: const Offset(0, 1),
            spreadRadius: -1,
          ),
          BoxShadow(
            color: AppColor.shadowMedium,
            blurRadius: 3,
            offset: const Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: AppColor.orange900,
            borderRadius: BorderRadius.circular(10),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: AppColor.white,
          unselectedLabelColor: AppColor.tabInactiveText,
          labelStyle: AppTextStyles.caption12.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
          unselectedLabelStyle: AppTextStyles.caption12.copyWith(
            color: AppColor.tabInactiveText,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
          tabs: const [
            Tab(text: 'نبذة'),
            Tab(text: 'الأعمال'),
            Tab(text: 'المنتجات'),
            Tab(text: 'التقييمات'),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutTab(ProfessionalVm pro) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      child: AboutCard(
        bio: pro.bio ?? '',
      ),
    );
  }

  Widget _buildWorksTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      child: WorksGrid(works: controller.works),
    );
  }

  Widget _buildProductsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      child: ProductsGrid(products: controller.products),
    );
  }

  Widget _buildReviewsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      child: ReviewsList(reviews: controller.reviews),
    );
  }
}
