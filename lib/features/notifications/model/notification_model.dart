import 'package:flutter/foundation.dart';

enum NotificationIconType {
  approval,
  payment,
  message,
  projectNearby,
  rejection,
}

@immutable
class NotificationModel {
  final String id;
  final String text;
  final String timeAgo;
  final bool isUnread;
  final NotificationIconType iconType;

  const NotificationModel({
    required this.id,
    required this.text,
    required this.timeAgo,
    required this.isUnread,
    required this.iconType,
  });
}
