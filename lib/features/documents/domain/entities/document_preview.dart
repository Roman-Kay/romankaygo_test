import 'package:equatable/equatable.dart';

class DocumentPreview extends Equatable {
  final String firstPageImagePath;
  final String? lastPageImagePath;
  final int pageCount;

  const DocumentPreview({
    required this.firstPageImagePath,
    required this.lastPageImagePath,
    required this.pageCount,
  });

  bool get hasLastPage => lastPageImagePath != null && pageCount > 1;

  @override
  List<Object?> get props => [firstPageImagePath, lastPageImagePath, pageCount];
}
