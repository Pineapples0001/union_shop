import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/cart_page.dart';
import 'package:union_shop/cart_manager.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/services/order_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('CartPage Tests', () {
    late AuthService authService;
    late OrderService orderService;
    late CartManager cartManager;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      authService = AuthService();
      orderService = OrderService();
      cartManager = CartManager();
      cartManager.clearCart();
      await Future.delayed(const Duration(milliseconds: 100));
    });

    Widget createTestWidget() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthService>.value(value: authService),
          ChangeNotifierProvider<OrderService>.value(value: orderService),
        ],
        child: MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(
              size: Size(1200, 800),
            ),
            child: const CartPage(),
          ),
        ),
      );
    }

    testWidgets('should display empty cart message', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Your cart is empty'), findsOneWidget);
    });

    testWidgets('should display continue shopping button when empty',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('CONTINUE SHOPPING'), findsOneWidget);
    });

    testWidgets('should display cart items', (tester) async {
      const product = Product(
        serial: 'TEST001',
        name: 'Test Product',
        price: 100.0,
        description: 'Test',
        imageUrl: 'https://via.placeholder.com/150',
        category: 'test',
        isSale: false,
      );

      cartManager.addToCart(product, 'M', 2);

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('Size: M'), findsOneWidget);
    });

    testWidgets('should display total price', (tester) async {
      const product = Product(
        serial: 'TEST001',
        name: 'Test Product',
        price: 100.0,
        description: 'Test',
        imageUrl: 'https://via.placeholder.com/150',
        category: 'test',
        isSale: false,
      );

      cartManager.addToCart(product, 'M', 2);

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.text('Subtotal:'), findsOneWidget);
      expect(find.textContaining('£200.00'), findsWidgets);
    });

    testWidgets('should have place order button', (tester) async {
      const product = Product(
        serial: 'TEST001',
        name: 'Test Product',
        price: 100.0,
        description: 'Test',
        imageUrl: 'https://via.placeholder.com/150',
        category: 'test',
        isSale: false,
      );

      cartManager.addToCart(product, 'M', 1);

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.text('Order'), findsOneWidget);
    });

    testWidgets('should display cart page title', (tester) async {
      const product = Product(
        serial: 'TEST001',
        name: 'Test Product',
        price: 100.0,
        description: 'Test',
        imageUrl: 'https://via.placeholder.com/150',
        category: 'test',
        isSale: false,
      );

      cartManager.addToCart(product, 'M', 1);

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.text('Shopping Cart'), findsOneWidget);
    });
  });
}
