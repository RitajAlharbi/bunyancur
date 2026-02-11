import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_bottom_nav.dart';
import '../../../core/routing/routes.dart';
import '../controller/client_controller.dart';
import 'widgets/order_card.dart';

class ClientOrdersScreen extends StatefulWidget {
  const ClientOrdersScreen({super.key});

  @override
  State<ClientOrdersScreen> createState() => _ClientOrdersScreenState();
}

class _ClientOrdersScreenState extends State<ClientOrdersScreen> {
  late final ClientController controller;

  @override
  void initState() {
    super.initState();
    controller = ClientController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, Routes.homeScreen);
      return;
    }
    if (index == 2) {
      Navigator.pushReplacementNamed(context, Routes.marketScreen);
      return;
    }
    if (index == 3) {
      Navigator.pushReplacementNamed(context, Routes.messagesScreen);
      return;
    }
    if (index == 1) return; // already on orders
    if (index == 4) {
      // TODO: profile
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'الطلبات',
            textAlign: TextAlign.center,
            style: AppTextStyles.title.copyWith(fontSize: 24.sp),
          ),
        ),
        body: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTabs(),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 8.h, bottom: 24.h),
                    itemCount: controller.currentOrders.length,
                    itemBuilder: (context, index) {
                      final order = controller.currentOrders[index];
                      return OrderCard(
                        order: order,
                        onDetails: () {
                          // TODO: onDetails
                          debugPrint('onDetails ${order.id}');
                        },
                        onOpenDashboard: () =>
                            controller.openDashboard(context, order),
                        onViewDescription: () {
                          // TODO: onViewDescription
                          debugPrint('onViewDescription ${order.id}');
                        },
                        onAccept: () {
                          // TODO: onAccept
                          debugPrint('onAccept ${order.id}');
                        },
                        onDecline: () {
                          // TODO: onDecline
                          debugPrint('onDecline ${order.id}');
                        },
                        onRate: () {
                          // TODO: onRate
                          debugPrint('onRate ${order.id}');
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: AppBottomNav(
          currentIndex: 1,
          onTap: _onNavTap,
        ),
      ),
    );
  }

  Widget _buildTabs() {
    const labels = ['نشط', 'قيد الانتظار', 'مكتمل'];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int index = 0; index < 3; index++) ...[
            if (index > 0) SizedBox(width: 24.w),
            GestureDetector(
              onTap: () => controller.setTab(index),
              behavior: HitTestBehavior.opaque,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    labels[index],
                    textAlign: TextAlign.center,
                    style: controller.selectedTabIndex == index
                        ? AppTextStyles.sectionTitle
                        : AppTextStyles.sectionTitle.copyWith(
                            color: AppColor.grey500,
                            fontWeight: FontWeight.w600,
                          ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    width: 80.w,
                    height: controller.selectedTabIndex == index ? 4.h : 2.h,
                    decoration: BoxDecoration(
                      color: controller.selectedTabIndex == index
                          ? AppColor.orange900
                          : AppColor.grey200,
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
