import 'package:flutter/foundation.dart';

import 'project_status.dart';

@immutable
class CurrentProjectModel {
  final String id;
  final String title;
  final String clientName;
  final String imagePath;
  final ProjectStatus status;

  const CurrentProjectModel({
    required this.id,
    required this.title,
    required this.clientName,
    required this.imagePath,
    required this.status,
  });
}
