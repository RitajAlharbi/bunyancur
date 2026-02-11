import 'package:flutter/foundation.dart';

@immutable
class ProjectModel {
  final String id;
  final String title;
  final String clientName;
  final String imagePath;
  final String status;
  final String? city;
  final String? date;
  final String? projectType;
  final String? budget;
  final String? area;
  final String? duration;
  final String? description;
  final List<String> galleryImagePaths;
  final String? mapLocation;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.clientName,
    required this.imagePath,
    required this.status,
    this.city,
    this.date,
    this.projectType,
    this.budget,
    this.area,
    this.duration,
    this.description,
    this.galleryImagePaths = const [],
    this.mapLocation,
  });
} 

