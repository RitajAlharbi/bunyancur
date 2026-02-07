import 'package:flutter/foundation.dart';

/// Filter type for Available Projects screen (pills: All, Area, Project Type, Budget).
enum FilterType {
  all,
  area,
  projectType,
  budget,
}

extension FilterTypeX on FilterType {
  String get label {
    switch (this) {
      case FilterType.all:
        return 'الكل';
      case FilterType.area:
        return 'المنطقة';
      case FilterType.projectType:
        return 'نوع المشروع';
      case FilterType.budget:
        return 'الميزانية';
    }
  }
}

@immutable
class FilterModel {
  final FilterType type;
  final bool isActive;

  const FilterModel({
    required this.type,
    required this.isActive,
  });
}
