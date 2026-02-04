import 'package:flutter/foundation.dart';

@immutable
class ProjectModel {
  final String id;
  final String titleAr;
  final String imagePathOrUrl;
  final String category;
  final String location;
  final String type;
  final String ctaTextAr;

  const ProjectModel({
    required this.id,
    required this.titleAr,
    required this.imagePathOrUrl,
    required this.category,
    required this.location,
    required this.type,
    required this.ctaTextAr,
  });

  ProjectModel copyWith({
    String? id,
    String? titleAr,
    String? imagePathOrUrl,
    String? category,
    String? location,
    String? type,
    String? ctaTextAr,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      titleAr: titleAr ?? this.titleAr,
      imagePathOrUrl: imagePathOrUrl ?? this.imagePathOrUrl,
      category: category ?? this.category,
      location: location ?? this.location,
      type: type ?? this.type,
      ctaTextAr: ctaTextAr ?? this.ctaTextAr,
    );
  }
}

