
/// Project status for filtering and display.
enum ProjectStatus {
  all,
  completed,
  inProgress,
  pendingApproval,
}

extension ProjectStatusX on ProjectStatus {
  String get label {
    switch (this) {
      case ProjectStatus.all:
        return 'الكل';
      case ProjectStatus.completed:
        return 'مكتمل';
      case ProjectStatus.inProgress:
        return 'قيد التنفيذ';
      case ProjectStatus.pendingApproval:
        return 'انتظار الموافقة';
    }
  }

  /// For filtering: only non-all statuses map to a concrete status.
  bool get isFilter => this != ProjectStatus.all;
}
