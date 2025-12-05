import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/services/order_service.dart';

void main() {
  group('ProductPage Tests', () {
    late AuthService authService;
    late OrderService orderService;

    const testProduct = Product(
      serial: 'TEST001',
      name: 'Test Product',
      price: 100.0,
      salePrice: 80.0,
      description: 'This is a test product description',
      imageUrl: 'https://via.placeholder.com/150',
      category: 'test',
      isSale: true,
    );

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
          home: ProductPage(product: testProduct),
        ),
      );
    }

    testWidgets('should display product name', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Test Product'), findsOneWidget);
    });

    testWidgets('should display product price', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.textContaining('£80.00'), findsWidgets);
    });

    testWidgets('should display sale price with strikethrough', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.textContaining('£100.00'), findsWidgets);
    });

    testWidgets('should display product description', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('This is a test product description'), findsOneWidget);
    });

    testWidgets('should display size options', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Size'), findsOneWidget);
    });

    testWidgets('should display add to cart button', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Add to Cart'), findsOneWidget);
    });

    testWidgets('should display quantity selector', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Quantity'), findsOneWidget);
      expect(find.byIcon(Icons.remove), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('should increment quantity', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final addButton = find.byIcon(Icons.add);
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('should decrement quantity', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // First increment to 2
      final addButton = find.byIcon(Icons.add);
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      // Then decrement back to 1
      final removeButton = find.byIcon(Icons.remove);
      await tester.tap(removeButton);
      await tester.pumpAndSettle();

      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('should not decrement below 1', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final removeButton = find.byIcon(Icons.remove);
      await tester.tap(removeButton);
      await tester.pumpAndSettle();

      expect(find.text('1'), findsOneWidget);
    });
  });
}
