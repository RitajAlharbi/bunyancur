import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routing/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../controllers/admin_projects_controller.dart';
import '../models/admin_project_model.dart';
import '../widgets/admin_project_card.dart';
import '../widgets/admin_status_filter_dropdown.dart';

/// Admin Dashboard with drawer navigation (Projects only).
class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({
    super.key,
    this.initialRoute = Routes.adminProjects,
  });

  final String initialRoute;

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  late String _currentRoute;
  late final AdminProjectsController _projectsController;

  @override
  void initState() {
    super.initState();
    _currentRoute = widget.initialRoute;
    _projectsController = AdminProjectsController();
  }

  @override
  void dispose() {
    _projectsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: _buildAppBar(),
        endDrawer: _buildDrawer(),
        body: _buildBody(),
      ),
    );
  }

  /// Single menu icon on the right (RTL): opens endDrawer from the right.
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColor.white,
      elevation: 0,
      centerTitle: false,
      title: Align(
        alignment: Alignment.centerRight,
        child: Text(
          _getTitle(),
          style: AppTextStyles.title,
          textAlign: TextAlign.right,
        ),
      ),
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(
            Icons.menu_rounded,
            color: AppColor.orange900,
            size: 24.sp,
          ),
          onPressed: () => Scaffold.of(context).openEndDrawer(),
        ),
      ),
    );
  }

  String _getTitle() {
    switch (_currentRoute) {
      case Routes.adminProjects:
        return 'المشاريع';
      default:
        return 'لوحة التحكم';
    }
  }

  Widget _buildDrawer() {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(24.w),
              color: AppColor.orange900.withValues(alpha: 0.08),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Icon(Icons.admin_panel_settings, color: AppColor.orange900, size: 32.sp),
                  SizedBox(width: 12.w),
                  Text(
                    'لوحة تحكم الأدمن',
                    style: AppTextStyles.sectionTitle,
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            _DrawerTile(
              icon: Icons.folder_outlined,
              label: 'المشاريع',
              isSelected: _currentRoute == Routes.adminProjects,
              onTap: () => _navigateTo(Routes.adminProjects),
            ),
            const Spacer(),
            ListTile(
              leading: Icon(Icons.logout, color: AppColor.grey600),
              title: Text(
                'تسجيل الخروج',
                style: AppTextStyles.body.copyWith(color: AppColor.grey700),
                textAlign: TextAlign.right,
              ),
              onTap: () => _logout(),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateTo(String route) {
    setState(() => _currentRoute = route);
    Navigator.pop(context); // close drawer
  }

  void _logout() {
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, Routes.roles);
  }

  Widget _buildBody() {
    return _AdminProjectsListScreen(controller: _projectsController);
  }
}

/// Admin Projects list: filter dropdown + cards from controller (mock data).
class _AdminProjectsListScreen extends StatelessWidget {
  final AdminProjectsController controller;

  const _AdminProjectsListScreen({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AdminStatusFilterDropdown(
                value: controller.selectedStatusLabel,
                options: controller.statusFilterOptions,
                onChanged: controller.updateStatusFilter,
              ),
              Expanded(
                child: controller.filteredProjects.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                        itemCount: controller.filteredProjects.length,
                        itemBuilder: (context, index) {
                          final project = controller.filteredProjects[index];
                          return AdminProjectCard(
                            project: project,
                            onView: () {},
                            onDelete: () => controller.deleteProject(project.id),
                            onMarkCompleted: project.status != AdminProjectStatus.completed
                                ? () => controller.markProjectAsCompleted(project.id)
                                : null,
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.folder_outlined, size: 64.sp, color: AppColor.grey400),
          SizedBox(height: 16.h),
          Text(
            'لا توجد مشاريع',
            style: AppTextStyles.sectionTitle,
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _DrawerTile({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppColor.orange900 : AppColor.grey600,
      ),
      title: Text(
        label,
        style: AppTextStyles.body.copyWith(
          color: isSelected ? AppColor.orange900 : AppColor.grey700,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
        ),
        textAlign: TextAlign.right,
      ),
      selected: isSelected,
      selectedTileColor: AppColor.orange900.withValues(alpha: 0.08),
      onTap: onTap,
    );
  }
}
