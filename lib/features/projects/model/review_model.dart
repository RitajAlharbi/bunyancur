import 'package:flutter/foundation.dart';

@immutable
class ReviewModel {
  final String clientName;
  final int rating; // 1-5 stars
  final String comment;
  final String? date;

  const ReviewModel({
    required this.clientName,
    required this.rating,
    required this.comment,
    this.date,
  });
}
