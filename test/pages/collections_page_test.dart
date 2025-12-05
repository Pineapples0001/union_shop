import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/collections_page.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/services/order_service.dart';

void main() {
  group('CollectionsPage Tests', () {
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
          home: CollectionsPage(),
        ),
      );
    }

    testWidgets('should display page title', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Collections'), findsWidgets);
    });

    testWidgets('should display collection categories', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(Card), findsWidgets);
    });

    testWidgets('should have scrollable content', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });
  });
}
