import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:test_romankaygo/app/app.dart';
import 'package:test_romankaygo/app/di/injection.dart';

void main() {
  testWidgets('shows documents home screen', (WidgetTester tester) async {
    await getIt.reset();
    configureDependencies();

    await tester.pumpWidget(const SignicaApp());
    await tester.pumpAndSettle();

    expect(find.text('Signica'), findsOneWidget);
    expect(find.text('No Documents Yet'), findsOneWidget);
    expect(find.text('Add Document'), findsOneWidget);
    expect(find.text('Files'), findsOneWidget);
    expect(find.text('Photos'), findsOneWidget);
    expect(find.text('Scanner'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();
    expect(find.text('Search Documents'), findsOneWidget);

    await tester.tap(find.byIcon(CupertinoIcons.xmark));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add Document'));
    await tester.pumpAndSettle();
    expect(find.text('Add Document From'), findsOneWidget);
  });

  testWidgets('dismisses actions menu by outside tap', (
    WidgetTester tester,
  ) async {
    await getIt.reset();
    configureDependencies();

    await tester.pumpWidget(const SignicaApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.more_horiz));
    await tester.pumpAndSettle();
    expect(find.text('Select'), findsOneWidget);

    await tester.tapAt(const Offset(220, 220));
    await tester.pumpAndSettle();
    expect(find.text('Select'), findsNothing);
  });
}
