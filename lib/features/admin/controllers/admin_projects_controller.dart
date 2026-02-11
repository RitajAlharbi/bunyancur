import 'package:flutter/foundation.dart';
import '../models/admin_project_model.dart';

/// Controller for the Admin projects list.
///
/// - Holds only mock data for now.
/// - Manages filtering, deletion and simple status changes.
/// - UI must listen to this controller and read data only from it.
class AdminProjectsController extends ChangeNotifier {
  static const String allStatusesLabel = 'جميع الحالات';

  final List<AdminProject> _projects = [
    const AdminProject(
      id: '1',
      title: 'فيلا سكنية - حي النرجس',
      ownerName: 'أحمد محمد',
      contractorName: 'شركة البناء الحديث',
      status: AdminProjectStatus.inProgress,
      progressPercent: 65,
    ),
    const AdminProject(
      id: '2',
      title: 'عمارة تجارية - طريق الملك فهد',
      ownerName: 'خالد سعيد',
      contractorName: 'مؤسسة التشييد الذهبية',
      status: AdminProjectStatus.newRequest,
      progressPercent: 0,
    ),
    const AdminProject(
      id: '3',
      title: 'مجمع فلل - حي الياسمين',
      ownerName: 'فاطمة حسن',
      contractorName: 'مقاولات الشرق',
      status: AdminProjectStatus.inProgress,
      progressPercent: 45,
    ),
    const AdminProject(
      id: '4',
      title: 'مركز تسوق - حي الروضة',
      ownerName: 'سارة عبدالله',
      contractorName: 'شركة البناء السريع',
      status: AdminProjectStatus.completed,
      progressPercent: 100,
    ),
    const AdminProject(
      id: '5',
      title: 'فيلا عصرية - حي العليا',
      ownerName: 'محمد يوسف',
      contractorName: 'مقاولون متحدون',
      status: AdminProjectStatus.inProgress,
      progressPercent: 80,
    ),
  ];

  AdminProjectStatus? _selectedStatus;

  /// All available filter options as text for the dropdown.
  List<String> get statusFilterOptions => [
        allStatusesLabel,
        ...AdminProjectStatus.values.map((status) => status.label),
      ];

  /// Currently selected status filter as text.
  String get selectedStatusLabel =>
      _selectedStatus?.label ?? allStatusesLabel;

  /// Projects after applying the selected status filter.
  List<AdminProject> get filteredProjects {
    if (_selectedStatus == null) {
      return List.unmodifiable(_projects);
    }
    return _projects
        .where((project) => project.status == _selectedStatus)
        .toList(growable: false);
  }

  /// Total projects count (used by dashboard summaries).
  int get totalProjects => _projects.length;

  /// Number of projects by status.
  int get newProjectsCount =>
      _projects.where((p) => p.status == AdminProjectStatus.newRequest).length;
  int get inProgressProjectsCount =>
      _projects.where((p) => p.status == AdminProjectStatus.inProgress).length;
  int get completedProjectsCount =>
      _projects.where((p) => p.status == AdminProjectStatus.completed).length;

  void updateStatusFilter(String? label) {
    if (label == null || label == allStatusesLabel) {
      if (_selectedStatus == null) return;
      _selectedStatus = null;
      notifyListeners();
      return;
    }

    final nextStatus = AdminProjectStatus.values.firstWhere(
      (status) => status.label == label,
      orElse: () => _selectedStatus ?? AdminProjectStatus.inProgress,
    );

    if (nextStatus == _selectedStatus) return;
    _selectedStatus = nextStatus;
    notifyListeners();
  }

  void deleteProject(String id) {
  _projects.removeWhere((project) => project.id == id);
  notifyListeners();
}

  void markProjectAsCompleted(String id) {
    final index = _projects.indexWhere((project) => project.id == id);
    if (index == -1) return;
    final current = _projects[index];
    if (current.status == AdminProjectStatus.completed) return;
    _projects[index] = current.copyWith(
      status: AdminProjectStatus.completed,
      progressPercent: 100,
    );
    notifyListeners();
  }
}

