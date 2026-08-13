import 'package:flutter_test/flutter_test.dart';
import 'package:test_romankaygo/features/documents/domain/services/document_title_resolver.dart';

void main() {
  group('DocumentTitleResolver', () {
    const resolver = DocumentTitleResolver();

    test('keeps title when it is unique', () {
      final result = resolver.resolve('Name', {'Other'});

      expect(result, 'Name');
    });

    test('appends next iOS-style suffix when title already exists', () {
      final result = resolver.resolve('Name', {'Name', 'Name 2', 'Name 3'});

      expect(result, 'Name 4');
    });

    test('appends next suffix for repeated New Document titles', () {
      final result = resolver.resolve('New Document', {
        'New Document',
        'New Document 2',
      });

      expect(result, 'New Document 3');
    });
  });
}
