import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_bottom_nav.dart';
import '../../../core/routing/routes.dart';
import '../controllers/messages_controller.dart';
import '../widgets/thread_tile.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  late final MessagesController controller;

  @override
  void initState() {
    super.initState();
    controller = MessagesController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _openThread(String threadId) {
    controller.openThread(threadId);
    Navigator.pushNamed(
      context,
      Routes.chatScreen,
      arguments: threadId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 0),
                    child: SizedBox(
                      height: 48.h,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'الرسائل',
                              style: AppTextStyles.title,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: SvgPicture.asset(
                              'assets/icons/Search.svg',
                              width: 24.w,
                              height: 24.h,
                              colorFilter: const ColorFilter.mode(
                                AppColor.orange900,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      itemCount: controller.threads.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1.h,
                        color: AppColor.grey200,
                      ),
                      itemBuilder: (context, index) {
                        final thread = controller.threads[index];
                        return ThreadTile(
                          thread: thread,
                          onTap: () => _openThread(thread.id),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 12.h),
                ],
              );
            },
          ),
        ),
        bottomNavigationBar: AppBottomNav(
          currentIndex: 3,
          onTap: (index) {
            if (index == 3) return;
            if (index == 0) {
              Navigator.pushReplacementNamed(context, Routes.homeScreen);
              return;
            }
            if (index == 2) {
              Navigator.pushReplacementNamed(context, Routes.marketScreen);
              return;
            }
            if (index == 1) {
              // TODO: OrdersScreen route
              Navigator.pushReplacementNamed(context, Routes.clientOrdersScreen);
              return;
            }
            if (index == 4) {
              Navigator.pushNamed(context, Routes.profileSettingsScreen);
              return;
            }
          },
        ),
      ),
    );
  }
}
