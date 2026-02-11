import 'package:flutter/foundation.dart';

/// Represents a single project entry in the Admin area.
///
/// All data is currently mock data and will later be replaced
/// by real backend responses. Keep this model free of any UI
/// concerns – it should only describe data.
@immutable
class AdminProject {
  final String id;
  final String title;
  final String ownerName;
  final String contractorName;
  final AdminProjectStatus status;
  /// Progress value from 0 to 100.
  final int progressPercent;

  const AdminProject({
    required this.id,
    required this.title,
    required this.ownerName,
    required this.contractorName,
    required this.status,
    required this.progressPercent,
  });

  AdminProject copyWith({
    String? id,
    String? title,
    String? ownerName,
    String? contractorName,
    AdminProjectStatus? status,
    int? progressPercent,
  }) {
    return AdminProject(
      id: id ?? this.id,
      title: title ?? this.title,
      ownerName: ownerName ?? this.ownerName,
      contractorName: contractorName ?? this.contractorName,
      status: status ?? this.status,
      progressPercent: progressPercent ?? this.progressPercent,
    );
  }
}

/// Logical status values for projects in the Admin area.
enum AdminProjectStatus {
  newRequest,
  inProgress,
  completed,
}

extension AdminProjectStatusX on AdminProjectStatus {
  /// Arabic label used across the Admin UI.
  String get label {
    switch (this) {
      case AdminProjectStatus.newRequest:
        return 'جديد';
      case AdminProjectStatus.inProgress:
        return 'جاري';
      case AdminProjectStatus.completed:
        return 'مكتمل';
    }
  }
}

