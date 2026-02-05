import 'package:flutter/foundation.dart';

@immutable
class ProjectModel {
  final String id;
  final String title;
  final String clientName;
  final String imagePath;
  final String status;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.clientName,
    required this.imagePath,
    required this.status,
  });
} 

