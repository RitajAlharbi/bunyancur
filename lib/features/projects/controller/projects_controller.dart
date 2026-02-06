import 'package:flutter/material.dart';

import '../../../core/routing/routes.dart';
import '../model/current_project_model.dart';
import '../model/project_status.dart';
import '../view/project_details_screen.dart';

class ProjectsController extends ChangeNotifier {
  ProjectsController({ProjectStatus? initialFilter}) {
    if (initialFilter != null) _selectedFilter = initialFilter;
    _loadMockData();
  }

  final List<CurrentProjectModel> _allProjects = [];
  ProjectStatus _selectedFilter = ProjectStatus.all;
  int _selectedBottomNavIndex = 1; // Projects tab active

  List<CurrentProjectModel> get allProjects => List.unmodifiable(_allProjects);
  ProjectStatus get selectedFilter => _selectedFilter;
  int get selectedBottomNavIndex => _selectedBottomNavIndex;

  List<CurrentProjectModel> get filteredProjects {
    if (_selectedFilter == ProjectStatus.all) return _allProjects;
    return _allProjects.where((p) => p.status == _selectedFilter).toList();
  }

  int countByStatus(ProjectStatus status) {
    if (status == ProjectStatus.all) return _allProjects.length;
    return _allProjects.where((p) => p.status == status).length;
  }

  void setFilter(ProjectStatus status) {
    if (_selectedFilter == status) return;
    _selectedFilter = status;
    notifyListeners();
  }

  void onBottomNavTap(int index, BuildContext context) {
    if (_selectedBottomNavIndex == index) return;
    _selectedBottomNavIndex = index;
    notifyListeners();
    _navigateFromBottomNav(index, context);
  }

  void _navigateFromBottomNav(int index, BuildContext context) {
    final navigator = Navigator.of(context);
    switch (index) {
      case 0:
        navigator.pushReplacementNamed(Routes.contractorHomeView);
        break;
      case 1:
        // Already on Projects
        break;
      case 2:
        navigator.pushReplacementNamed(Routes.contractorHomeView);
        break;
      case 3:
        navigator.pushReplacementNamed(Routes.contractorHomeView);
        break;
      case 4:
        navigator.pushReplacementNamed(Routes.contractorHomeView);
        break;
    }
  }

  void onViewDetails(CurrentProjectModel project, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProjectDetailsScreen(project: project),
      ),
    );
  }

  void _loadMockData() {
    _allProjects.addAll(const [
      CurrentProjectModel(
        id: '1',
        title: 'بناء مجلس خارجي',
        clientName: 'العميل: محمد خالد',
        imagePath: 'assets/images/projects/مجلس.png',
        status: ProjectStatus.completed,
      ),
      CurrentProjectModel(
        id: '2',
        title: 'بناء فيلا كاملة',
        clientName: 'العميل: محمد خالد',
        imagePath: 'assets/images/projects/فيلا.png',
        status: ProjectStatus.completed,
      ),
      CurrentProjectModel(
        id: '3',
        title: 'ترميم واجهة فيلا',
        clientName: 'العميل: سعد محمد',
        imagePath: 'assets/images/projects/ترميم.png',
        status: ProjectStatus.inProgress,
      ),
      CurrentProjectModel(
        id: '4',
        title: 'بناء عظم فيلا',
        clientName: 'العميل: محمد خالد',
        imagePath: 'assets/images/projects/تجديد.png',
        status: ProjectStatus.pendingApproval,
      ),
      CurrentProjectModel(
        id: '5',
        title: 'تنفيذ فيلا سكنية',
        clientName: 'العميل: فهد العتيبي',
        imagePath: 'assets/images/projects/فيلا.png',
        status: ProjectStatus.inProgress,
      ),
      CurrentProjectModel(
        id: '6',
        title: 'بيت فيلا كامل',
        clientName: 'العميل: محمد خالد',
        imagePath: 'assets/images/projects/فيلا.png',
        status: ProjectStatus.pendingApproval,
      ),
      CurrentProjectModel(
        id: '7',
        title: ' بناء مجلس خارجي  ',
        clientName: 'العميل: عبدالرحمن',
        imagePath: 'assets/images/projects/مجلس.png',
        status: ProjectStatus.inProgress,
      ),
    ]);
    notifyListeners();
  }
}
