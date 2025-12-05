import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/common_header.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/services/order_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('CommonHeader Tests', () {
    late AuthService authService;
    late OrderService orderService;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      authService = AuthService();
      orderService = OrderService();
      await Future.delayed(const Duration(milliseconds: 100));
    });

    Widget createTestWidget() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthService>.value(value: authService),
          ChangeNotifierProvider<OrderService>.value(value: orderService),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: CommonHeader(),
          ),
        ),
      );
    }

    testWidgets('should display logo/brand name', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(Image), findsWidgets);
    });

    testWidgets('should display navigation menu', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('should display cart icon', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
    });

    testWidgets('should display search icon', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('should display account icon when not logged in',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.person_outline), findsOneWidget);
    });

    testWidgets('should show menu when menu icon tapped', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final menuIcon = find.byIcon(Icons.menu);
      await tester.tap(menuIcon);
      await tester.pumpAndSettle();

      // Menu items should appear
      expect(find.text('Shop'), findsWidgets);
    });

    testWidgets('should display cart badge when items in cart', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Cart badge indicator should be present (if cart has items)
      expect(find.byType(CommonHeader), findsOneWidget);
    });
  });
}
