import 'package:flutter/foundation.dart';

@immutable
class DesignerProjectCardModel {
  final String id;
  final String title;
  final String? subtitle1;
  final String? subtitle2;
  final String imagePathOrUrl;
  final String actionText;

  const DesignerProjectCardModel({
    required this.id,
    required this.title,
    required this.imagePathOrUrl,
    required this.actionText,
    this.subtitle1,
    this.subtitle2,
  });

  DesignerProjectCardModel copyWith({
    String? id,
    String? title,
    String? subtitle1,
    String? subtitle2,
    String? imagePathOrUrl,
    String? actionText,
  }) {
    return DesignerProjectCardModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle1: subtitle1 ?? this.subtitle1,
      subtitle2: subtitle2 ?? this.subtitle2,
      imagePathOrUrl: imagePathOrUrl ?? this.imagePathOrUrl,
      actionText: actionText ?? this.actionText,
    );
  }
}
