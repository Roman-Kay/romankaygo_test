import 'package:equatable/equatable.dart';

import 'document_preview.dart';
import 'document_status.dart';

class Document extends Equatable {
  final String id;
  final String title;
  final String filePath;
  final DocumentPreview preview;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DocumentStatus status;

  const Document({
    required this.id,
    required this.title,
    required this.filePath,
    required this.preview,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  Document copyWith({
    String? id,
    String? title,
    String? filePath,
    DocumentPreview? preview,
    DateTime? createdAt,
    DateTime? updatedAt,
    DocumentStatus? status,
  }) {
    return Document(
      id: id ?? this.id,
      title: title ?? this.title,
      filePath: filePath ?? this.filePath,
      preview: preview ?? this.preview,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    filePath,
    preview,
    createdAt,
    updatedAt,
    status,
  ];
}
