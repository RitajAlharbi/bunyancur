import 'package:flutter/material.dart';

import '../../../core/routing/routes.dart';
import '../model/contractor_project_model.dart';

class ContractorHomeController extends ChangeNotifier {
  ContractorHomeController() {
    _loadMockData();
  }

  final List<ContractorProjectModel> _currentProjects = [];
  final List<ContractorProjectModel> _availableProjects = [];

  List<ContractorProjectModel> get currentProjects =>
      List.unmodifiable(_currentProjects);
  List<ContractorProjectModel> get availableProjects =>
      List.unmodifiable(_availableProjects);

  int _selectedBottomNavIndex = 0;
  int get selectedBottomNavIndex => _selectedBottomNavIndex;

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
        // Already on Contractor Home (الرئيسية)
        break;
      case 1:
        navigator.pushReplacementNamed(Routes.projectsScreen);
        break;
      case 2:
      case 3:
      case 4:
        // Placeholder: stay or navigate when those screens exist
        break;
    }
  }

  void _loadMockData() {
    _currentProjects.addAll(const [
      ContractorProjectModel(
        id: '1',
        title: 'بناء مجلس خارجي',
        clientName: 'العميل: احمد محمد',
        imagePath: 'assets/images/projects/مجلس.png',
        location: 'الخرج',
      ),
      ContractorProjectModel(
        id: '2',
        title: 'بناء فيلا كاملة',
        clientName: 'العميل: صالح محمد',
        imagePath: 'assets/images/projects/فيلا.png',
        location: 'الخرج',
      ),
    ]);

    _availableProjects.addAll(const [
      ContractorProjectModel(
        id: '3',
        title: 'تجديد واجهة محل تجاري',
        clientName: '',
        imagePath: 'assets/images/projects/تجديد.png',
        location: '',
      ),
      ContractorProjectModel(
        id: '4',
        title: 'ترميم جزء من فيلا',
        clientName: '',
        imagePath: 'assets/images/projects/ترميم.png',
        location: '',
      ),
    ]);

    notifyListeners();
  }
}
