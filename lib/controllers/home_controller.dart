import 'package:flutter/material.dart';

import '../models/project_model.dart';

class HomeController extends ChangeNotifier {
  HomeController() {
    _loadMockData();
  }

  final List<ProjectModel> _currentProjects = [];
  final List<ProjectModel> _availableProjects = [];

  List<ProjectModel> get currentProjects => List.unmodifiable(_currentProjects);
  List<ProjectModel> get availableProjects =>
      List.unmodifiable(_availableProjects);

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void onBottomNavTap(int index) {
    if (_selectedIndex == index) return;
    _selectedIndex = index;
    notifyListeners();
  }

  void _loadMockData() {
    _currentProjects.addAll([
      const ProjectModel(
        id: '1',
        title: 'بناء مجلس خارجي',
        clientName: 'العميل: احمد محمد',
        imagePath: 'assets/images/Rectangle.png',
        status: 'الخرج',
      ),
      const ProjectModel(
        id: '2',
        title: 'بناء فيلا كاملة',
        clientName: 'العميل: صالح محمد',
        imagePath: 'assets/images/الصفحه الرئيسه/Rectangle.png',
        status: 'الخرج',
      ),
    ]);

    _availableProjects.addAll([
      const ProjectModel(
        id: '3',
        title: 'تجديد واجهة محل تجاري',
        clientName: '',
        imagePath: 'assets/images/Rectangle (1).png',
        status: '',
      ),
      const ProjectModel(
        id: '4',
        title: 'ترميم جزء من فيلا',
        clientName: '',
        imagePath: 'assets/images/Rectangle (2).png',
        status: '',
      ),
    ]);

    notifyListeners();
  }
}

