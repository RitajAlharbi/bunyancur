import 'package:flutter/material.dart';

import '../../../core/routing/routes.dart';
import '../../../models/project_model.dart';
import '../model/filter_model.dart';

class AvailableProjectsController extends ChangeNotifier {
  AvailableProjectsController() {
    _loadMockData();
  }

  final List<ProjectModel> _allProjects = [];
  FilterType _selectedFilter = FilterType.all;
  int _selectedBottomNavIndex = 0; // Home active on this screen

  List<ProjectModel> get allProjects => List.unmodifiable(_allProjects);
  FilterType get selectedFilter => _selectedFilter;
  int get selectedBottomNavIndex => _selectedBottomNavIndex;

  List<ProjectModel> get filteredProjects {
    if (_selectedFilter == FilterType.all) return _allProjects;
    // Placeholder: other filters would filter by area/type/budget when implemented
    return _allProjects;
  }

  void setFilter(FilterType type) {
    if (_selectedFilter == type) return;
    _selectedFilter = type;
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
        // Already on Available Projects (المشاريع)
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

  void onViewDetails(ProjectModel project, BuildContext context) {
    // Navigate to project details when screen exists
    Navigator.of(context).pushNamed(Routes.projectsScreen);
  }

  void _loadMockData() {
    _allProjects.addAll(const [
      ProjectModel(
        id: '1',
        title: 'تجديد واجهة محل تجاري',
        clientName: '',
        imagePath: 'assets/images/projects/تجديد.png',
        status: '',
      ),
      ProjectModel(
        id: '2',
        title: 'ترميم منزل قديم',
        clientName: '',
        imagePath: 'assets/images/projects/فيلا.png',
        status: '',
      ),
      ProjectModel(
        id: '3',
        title: 'ترميم واجهة فيلا قديمة',
        clientName: '',
        imagePath: 'assets/images/projects/ترميم.png',
        status: '',
      ),
      ProjectModel(
        id: '4',
        title: 'بناء مجلس خارجي',
        clientName: '',
        imagePath: 'assets/images/projects/مجلس.png',
        status: '',
      ),
    ]);
    notifyListeners();
  }
}
