import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/common_footer.dart';

void main() {
  group('CommonFooter Tests', () {
    Widget createTestWidget() {
      return MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: const CommonFooter(),
          ),
        ),
      );
    }

    testWidgets('should display footer content', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(CommonFooter), findsOneWidget);
    });

    testWidgets('should display copyright text', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.textContaining('©'), findsWidgets);
    });

    testWidgets('should display footer links', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('should have proper layout', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(Container), findsWidgets);
    });
  });
}
