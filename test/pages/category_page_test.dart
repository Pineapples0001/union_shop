import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/category_page.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/services/order_service.dart';

void main() {
  group('CategoryPage Tests', () {
    late AuthService authService;
    late OrderService orderService;

    setUp(() {
      authService = AuthService();
      orderService = OrderService();
    });

    Widget createTestWidget(String category) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthService>.value(value: authService),
          ChangeNotifierProvider<OrderService>.value(value: orderService),
        ],
        child: MaterialApp(
          home: CategoryPage(categoryName: category),
        ),
      );
    }

    testWidgets('should display category name', (tester) async {
      await tester.pumpWidget(createTestWidget('Hoodies'));
      await tester.pumpAndSettle();

      expect(find.text('Hoodies'), findsWidgets);
    });

    testWidgets('should display products in grid', (tester) async {
      await tester.pumpWidget(createTestWidget('Hoodies'));
      await tester.pumpAndSettle();

      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('should display product cards', (tester) async {
      await tester.pumpWidget(createTestWidget('Hoodies'));
      await tester.pumpAndSettle();

      // Should have some products displayed
      expect(find.byType(Card), findsWidgets);
    });

    testWidgets('should display pagination controls', (tester) async {
      await tester.pumpWidget(createTestWidget('Hoodies'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.chevron_left), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('should display current page number', (tester) async {
      await tester.pumpWidget(createTestWidget('Hoodies'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Page'), findsOneWidget);
    });

    testWidgets('should navigate to next page', (tester) async {
      await tester.pumpWidget(createTestWidget('Hoodies'));
      await tester.pumpAndSettle();

      final nextButton = find.byIcon(Icons.chevron_right);
      await tester.tap(nextButton);
      await tester.pumpAndSettle();

      // Page number should change
      expect(find.text('Page 2'), findsOneWidget);
    });

    testWidgets('should filter products by category', (tester) async {
      await tester.pumpWidget(createTestWidget('T-Shirts'));
      await tester.pumpAndSettle();

      // Products should be filtered to only T-Shirts category
      expect(find.byType(Card), findsWidgets);
    });
  });
}
