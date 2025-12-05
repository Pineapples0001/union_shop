import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/print_shack_page.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/services/order_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('PrintShackPage Tests', () {
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
          home: PrintShackPage(),
        ),
      );
    }

    testWidgets('should display page title', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Custom Print'), findsOneWidget);
    });

    testWidgets('should display base price', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.textContaining('£7.00'), findsWidgets);
    });

    testWidgets('should display text input fields', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsWidgets);
    });

    testWidgets('should display add line button', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Add Line'), findsOneWidget);
    });

    testWidgets('should display size options', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Size'), findsOneWidget);
    });

    testWidgets('should add text line when button clicked', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final initialTextFields = find.byType(TextField).evaluate().length;

      final addLineButton = find.text('Add Line');
      await tester.tap(addLineButton);
      await tester.pumpAndSettle();

      final newTextFields = find.byType(TextField).evaluate().length;
      expect(newTextFields, greaterThan(initialTextFields));
    });

    testWidgets('should update total price when adding lines', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Initial price should be base price (£7)
      expect(find.textContaining('£7.00'), findsWidgets);

      final addLineButton = find.text('Add Line');
      await tester.tap(addLineButton);
      await tester.pumpAndSettle();

      // After adding a line, price should increase by £3 (total £10)
      expect(find.textContaining('£10.00'), findsWidgets);
    });

    testWidgets('should display add to cart button', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Add to Cart'), findsOneWidget);
    });

    testWidgets('should display preview section', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Preview'), findsOneWidget);
    });

    testWidgets('should remove line when delete button clicked',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Add a line first
      final addLineButton = find.text('Add Line');
      await tester.tap(addLineButton);
      await tester.pumpAndSettle();

      // Find and tap delete icon
      final deleteIcon = find.byIcon(Icons.delete_outline).first;
      await tester.tap(deleteIcon);
      await tester.pumpAndSettle();

      // Price should go back down
      expect(find.textContaining('£7.00'), findsWidgets);
    });
  });
}
