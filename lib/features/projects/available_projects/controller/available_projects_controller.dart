import 'package:flutter/foundation.dart';

import '../model/project_model.dart';

enum ProjectFilterChip {
  all,
  area,
  type,
  budget,
}

extension ProjectFilterChipX on ProjectFilterChip {
  String get labelAr {
    switch (this) {
      case ProjectFilterChip.all:
        return 'الكل';
      case ProjectFilterChip.area:
        return 'المنطقة';
      case ProjectFilterChip.type:
        return 'نوع المشروع';
      case ProjectFilterChip.budget:
        return 'الميزانية';
    }
  }
}

class AvailableProjectsController extends ChangeNotifier {
  ProjectFilterChip selectedChip = ProjectFilterChip.all;

  final List<ProjectModel> _allProjects = const [
    ProjectModel(
      id: '1',
      titleAr: 'ترميم منزل قديم',
      imagePathOrUrl: 'assets/images/Rectangle (2).png',
      category: 'ترميم',
      location: 'الرياض',
      type: 'منزل',
      ctaTextAr: 'عرض التفاصيل',
    ),
    ProjectModel(
      id: '2',
      titleAr: 'تجديد واجهة محل تجاري',
      imagePathOrUrl: 'assets/images/service1.png',
      category: 'تجديد',
      location: 'الخرج',
      type: 'محل تجاري',
      ctaTextAr: 'عرض التفاصيل',
    ),
    ProjectModel(
      id: '3',
      titleAr: 'ترميم واجهة بناء قديمة',
      imagePathOrUrl: 'assets/images/service2.png',
      category: 'ترميم',
      location: 'جدة',
      type: 'واجهة بناء',
      ctaTextAr: 'عرض التفاصيل',
    ),
  ];

  List<ProjectModel> get filteredProjects {
    // Currently all filters return the same mock projects list.
    // This keeps the UI behaviour simple while allowing future expansion.
    switch (selectedChip) {
      case ProjectFilterChip.all:
        return List.unmodifiable(_allProjects);
      case ProjectFilterChip.area:
        return List.unmodifiable(
          _allProjects.where((p) => p.location.isNotEmpty),
        );
      case ProjectFilterChip.type:
        return List.unmodifiable(
          _allProjects.where((p) => p.type.isNotEmpty),
        );
      case ProjectFilterChip.budget:
        // No budget data in mock model yet, so we keep all items.
        return List.unmodifiable(_allProjects);
    }
  }

  void selectChip(ProjectFilterChip chip) {
    if (selectedChip == chip) return;
    selectedChip = chip;
    notifyListeners();
  }
}

