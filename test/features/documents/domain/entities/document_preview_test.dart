import 'package:flutter_test/flutter_test.dart';
import 'package:test_romankaygo/features/documents/domain/entities/document_preview.dart';

void main() {
  group('DocumentPreview', () {
    test(
      'hasLastPage is true only when last page path exists and page count is greater than one',
      () {
        expect(
          const DocumentPreview(
            firstPageImagePath: 'first.jpg',
            lastPageImagePath: 'last.jpg',
            pageCount: 2,
          ).hasLastPage,
          isTrue,
        );

        expect(
          const DocumentPreview(
            firstPageImagePath: 'first.jpg',
            lastPageImagePath: null,
            pageCount: 2,
          ).hasLastPage,
          isFalse,
        );

        expect(
          const DocumentPreview(
            firstPageImagePath: 'first.jpg',
            lastPageImagePath: 'last.jpg',
            pageCount: 1,
          ).hasLastPage,
          isFalse,
        );
      },
    );
  });
}
