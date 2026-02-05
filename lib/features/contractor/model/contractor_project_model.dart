import 'package:flutter/foundation.dart';

@immutable
class ContractorProjectModel {
  final String id;
  final String title;
  final String imagePath;
  final String clientName;
  final String location;

  const ContractorProjectModel({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.clientName,
    required this.location,
  });
}

