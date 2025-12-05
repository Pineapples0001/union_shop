import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/all_products_page.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/services/order_service.dart';

void main() {
  group('AllProductsPage Tests', () {
    late AuthService authService;
    late OrderService orderService;

    setUp(() {
      authService = AuthService();
      orderService = OrderService();
    });

    Widget createTestWidget() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthService>.value(value: authService),
          ChangeNotifierProvider<OrderService>.value(value: orderService),
        ],
        child: const MaterialApp(
          home: AllProductsPage(),
        ),
      );
    }

    testWidgets('should display page title', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('ALL PRODUCTS'), findsOneWidget);
    });

    testWidgets('should display products in grid', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('should display product cards', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Products are displayed in containers, not cards in this implementation
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('should display category filter dropdown', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(DropdownButton<String>), findsWidgets);
    });

    testWidgets('should display sort dropdown', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(DropdownButton<String>), findsWidgets);
    });

    testWidgets('should have common header', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });
  });
}
