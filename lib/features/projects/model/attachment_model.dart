import 'package:flutter/foundation.dart';

@immutable
class AttachmentModel {
  final String id;
  final String fileName;
  final String filePath;
  final String? fileSize;

  const AttachmentModel({
    required this.id,
    required this.fileName,
    required this.filePath,
    this.fileSize,
  });
}
