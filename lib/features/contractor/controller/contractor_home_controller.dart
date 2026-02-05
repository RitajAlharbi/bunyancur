import 'package:flutter/material.dart';

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

  int _selectedBottomIndex = 0;
  int get selectedBottomIndex => _selectedBottomIndex;

  void onBottomNavTap(int index) {
    if (_selectedBottomIndex == index) return;
    _selectedBottomIndex = index;
    notifyListeners();
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
