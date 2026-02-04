import 'package:flutter/foundation.dart';
import '../models/create_project_form_data.dart';

class CreateProjectController extends ChangeNotifier {
  CreateProjectFormData _data = const CreateProjectFormData();

  CreateProjectFormData get data => _data;

  final List<String> projectTypes = const [
    'ديكور وتشطيب',
    'أعمال السقف',
    'السباكة',
    'الكهرباء',
    'ترميم فيلا',
    'تجديد المطبخ',
    'أعمال الأساسات',
    'بناء كامل',
    'أخرى',
  ];

  final List<String> projectAreas = const [
    '100 أو أقل',
    '150 - 200',
    '200 - 300',
    '400 - 500',
    '1000 أو أكثر',
  ];

  void updateProjectName(String value) {
    if (_data.projectName == value) return;
    _data = _data.copyWith(projectName: value);
    notifyListeners();
  }

  void updateProjectType(String? value) {
    if (_data.projectType == value) return;
    _data = _data.copyWith(projectType: value);
    notifyListeners();
  }

  void updateProjectArea(String value) {
    if (_data.projectArea == value) return;
    _data = _data.copyWith(projectArea: value);
    notifyListeners();
  }

  void updateProjectDescription(String value) {
    if (_data.projectDescription == value) return;
    _data = _data.copyWith(projectDescription: value);
    notifyListeners();
  }
}
