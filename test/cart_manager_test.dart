import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/cart_manager.dart';
import 'package:union_shop/main.dart';

void main() {
  group('CartManager Tests', () {
    late CartManager cartManager;

    setUp(() {
      cartManager = CartManager();
      cartManager.clearCart();
    });

    test('should be a singleton', () {
      final instance1 = CartManager();
      final instance2 = CartManager();
      expect(instance1, equals(instance2));
    });

    test('should start with empty cart', () {
      expect(cartManager.cartItems, isEmpty);
      expect(cartManager.itemCount, equals(0));
      expect(cartManager.totalPrice, equals(0.0));
    });

    test('should add item to cart', () {
      final product = Product(
        serial: 'TEST001',
        name: 'Test Product',
        category: 'Test',
        description: 'Test Description',
        price: 10.0,
        isSale: false,
        salePrice: null,
        imageUrl: 'test.jpg',
        isVisible: true,
      );

      cartManager.addToCart(product, 'M', 1);

      expect(cartManager.itemCount, equals(1));
      expect(cartManager.cartItems.first.product.name, equals('Test Product'));
      expect(cartManager.cartItems.first.size, equals('M'));
      expect(cartManager.cartItems.first.quantity, equals(1));
    });

    test('should update quantity if same product and size added', () {
      final product = Product(
        serial: 'TEST001',
        name: 'Test Product',
        category: 'Test',
        description: 'Test Description',
        price: 10.0,
        isSale: false,
        salePrice: null,
        imageUrl: 'test.jpg',
        isVisible: true,
      );

      cartManager.addToCart(product, 'M', 1);
      cartManager.addToCart(product, 'M', 2);

      expect(cartManager.itemCount, equals(1));
      expect(cartManager.cartItems.first.quantity, equals(3));
    });

    test('should add separate items for different sizes', () {
      final product = Product(
        serial: 'TEST001',
        name: 'Test Product',
        category: 'Test',
        description: 'Test Description',
        price: 10.0,
        isSale: false,
        salePrice: null,
        imageUrl: 'test.jpg',
        isVisible: true,
      );

      cartManager.addToCart(product, 'M', 1);
      cartManager.addToCart(product, 'L', 1);

      expect(cartManager.itemCount, equals(2));
    });

    test('should remove item from cart', () {
      final product = Product(
        serial: 'TEST001',
        name: 'Test Product',
        category: 'Test',
        description: 'Test Description',
        price: 10.0,
        isSale: false,
        salePrice: null,
        imageUrl: 'test.jpg',
        isVisible: true,
      );

      cartManager.addToCart(product, 'M', 1);
      cartManager.removeFromCart(0);

      expect(cartManager.itemCount, equals(0));
      expect(cartManager.itemCountNotifier.value, equals(0));
    });

    test('should not remove item with invalid index', () {
      final product = Product(
        serial: 'TEST001',
        name: 'Test Product',
        category: 'Test',
        description: 'Test Description',
        price: 10.0,
        isSale: false,
        salePrice: null,
        imageUrl: 'test.jpg',
        isVisible: true,
      );

      cartManager.addToCart(product, 'M', 1);
      cartManager.removeFromCart(5);

      expect(cartManager.itemCount, equals(1));
    });

    test('should update item quantity', () {
      final product = Product(
        serial: 'TEST001',
        name: 'Test Product',
        category: 'Test',
        description: 'Test Description',
        price: 10.0,
        isSale: false,
        salePrice: null,
        imageUrl: 'test.jpg',
        isVisible: true,
      );

      cartManager.addToCart(product, 'M', 1);
      cartManager.updateQuantity(0, 5);

      expect(cartManager.cartItems.first.quantity, equals(5));
    });

    test('should not update quantity with invalid index', () {
      final product = Product(
        serial: 'TEST001',
        name: 'Test Product',
        category: 'Test',
        description: 'Test Description',
        price: 10.0,
        isSale: false,
        salePrice: null,
        imageUrl: 'test.jpg',
        isVisible: true,
      );

      cartManager.addToCart(product, 'M', 1);
      cartManager.updateQuantity(5, 10);

      expect(cartManager.cartItems.first.quantity, equals(1));
    });

    test('should calculate total price correctly', () {
      final product1 = Product(
        serial: 'TEST001',
        name: 'Test Product 1',
        category: 'Test',
        description: 'Test Description',
        price: 10.0,
        isSale: false,
        salePrice: null,
        imageUrl: 'test.jpg',
        isVisible: true,
      );

      final product2 = Product(
        serial: 'TEST002',
        name: 'Test Product 2',
        category: 'Test',
        description: 'Test Description',
        price: 20.0,
        isSale: true,
        salePrice: 15.0,
        imageUrl: 'test.jpg',
        isVisible: true,
      );

      cartManager.addToCart(product1, 'M', 2);
      cartManager.addToCart(product2, 'L', 1);

      expect(cartManager.totalPrice, equals(35.0)); // (10*2) + (15*1)
    });

    test('should clear cart', () {
      final product = Product(
        serial: 'TEST001',
        name: 'Test Product',
        category: 'Test',
        description: 'Test Description',
        price: 10.0,
        isSale: false,
        salePrice: null,
        imageUrl: 'test.jpg',
        isVisible: true,
      );

      cartManager.addToCart(product, 'M', 1);
      cartManager.clearCart();

      expect(cartManager.itemCount, equals(0));
      expect(cartManager.itemCountNotifier.value, equals(0));
      expect(cartManager.totalPrice, equals(0.0));
    });

    test('should notify listeners on item count change', () {
      final product = Product(
        serial: 'TEST001',
        name: 'Test Product',
        category: 'Test',
        description: 'Test Description',
        price: 10.0,
        isSale: false,
        salePrice: null,
        imageUrl: 'test.jpg',
        isVisible: true,
      );

      int notificationCount = 0;
      cartManager.itemCountNotifier.addListener(() {
        notificationCount++;
      });

      cartManager.addToCart(product, 'M', 1);
      expect(notificationCount, equals(1));
      expect(cartManager.itemCountNotifier.value, equals(1));

      cartManager.removeFromCart(0);
      expect(notificationCount, equals(2));
      expect(cartManager.itemCountNotifier.value, equals(0));
    });
  });
}
