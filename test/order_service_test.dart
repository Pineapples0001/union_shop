import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/order_service.dart';
import 'package:union_shop/models/order_model.dart';
import 'package:union_shop/cart_manager.dart';
import 'package:union_shop/main.dart';

void main() {
  group('OrderService Tests', () {
    late OrderService orderService;
    late CartManager cartManager;

    setUp(() {
      orderService = OrderService();
      cartManager = CartManager();
      cartManager.clearCart();
    });

    tearDown(() {
      cartManager.clearCart();
    });

    test('should start with empty orders', () {
      expect(orderService.getUserOrders('user1'), isEmpty);
      expect(orderService.getTotalOrders('user1'), equals(0));
    });

    test('should place an order successfully', () async {
      const product = Product(
        serial: '1',
        name: 'Test Product',
        price: 100.0,
        description: 'Test',
        imageUrl: 'test.jpg',
        category: 'test',
        isSale: false,
      );

      cartManager.addToCart(product, 'M', 2);

      final order = await orderService.placeOrder(
        userId: 'user1',
        cartManager: cartManager,
        shippingAddress: '123 Test St',
      );

      expect(order, isNotNull);
      expect(order.userId, equals('user1'));
      expect(order.items.length, equals(1));
      expect(order.items[0].productName, equals('Test Product'));
      expect(order.items[0].quantity, equals(2));
      expect(order.items[0].size, equals('M'));
      expect(order.totalAmount, equals(200.0));
      expect(order.status, equals('processing'));
      expect(order.shippingAddress, equals('123 Test St'));
    });

    test('should place order with multiple items', () async {
      const product1 = Product(
        serial: '1',
        name: 'Product 1',
        price: 100.0,
        description: 'Test',
        imageUrl: 'test1.jpg',
        category: 'test',
        isSale: false,
      );

      const product2 = Product(
        serial: '2',
        name: 'Product 2',
        price: 50.0,
        description: 'Test',
        imageUrl: 'test2.jpg',
        category: 'test',
        isSale: false,
      );

      cartManager.addToCart(product1, 'M', 1);
      cartManager.addToCart(product2, 'L', 2);

      final order = await orderService.placeOrder(
        userId: 'user1',
        cartManager: cartManager,
        shippingAddress: '123 Test St',
      );

      expect(order.items.length, equals(2));
      expect(order.totalAmount, equals(200.0)); // 100 + (50*2)
    });

    test('should handle sale prices in orders', () async {
      const product = Product(
        serial: '1',
        name: 'Sale Product',
        price: 100.0,
        salePrice: 80.0,
        description: 'Test',
        imageUrl: 'test.jpg',
        category: 'test',
        isSale: true,
      );

      cartManager.addToCart(product, 'M', 2);

      final order = await orderService.placeOrder(
        userId: 'user1',
        cartManager: cartManager,
        shippingAddress: '123 Test St',
      );

      expect(order.totalAmount, equals(160.0)); // 80*2
      expect(order.items[0].price, equals(80.0));
    });

    test('should generate unique order IDs', () async {
      const product = Product(
        serial: '1',
        name: 'Test Product',
        price: 100.0,
        description: 'Test',
        imageUrl: 'test.jpg',
        category: 'test',
        isSale: false,
      );

      cartManager.addToCart(product, 'M', 1);
      final order1 = await orderService.placeOrder(
        userId: 'user1',
        cartManager: cartManager,
        shippingAddress: '123 Test St',
      );

      cartManager.addToCart(product, 'M', 1);
      final order2 = await orderService.placeOrder(
        userId: 'user1',
        cartManager: cartManager,
        shippingAddress: '123 Test St',
      );

      expect(order1.id, isNot(equals(order2.id)));
    });

    test('should generate tracking numbers', () async {
      const product = Product(
        serial: '1',
        name: 'Test Product',
        price: 100.0,
        description: 'Test',
        imageUrl: 'test.jpg',
        category: 'test',
        isSale: false,
      );

      cartManager.addToCart(product, 'M', 1);
      final order = await orderService.placeOrder(
        userId: 'user1',
        cartManager: cartManager,
        shippingAddress: '123 Test St',
      );

      expect(order.trackingNumber, isNotNull);
      expect(order.trackingNumber, contains('TRK'));
    });

    test('should get orders for specific user', () async {
      const product = Product(
        serial: '1',
        name: 'Test Product',
        price: 100.0,
        description: 'Test',
        imageUrl: 'test.jpg',
        category: 'test',
        isSale: false,
      );

      cartManager.addToCart(product, 'M', 1);
      await orderService.placeOrder(
        userId: 'user1',
        cartManager: cartManager,
        shippingAddress: '123 Test St',
      );

      cartManager.addToCart(product, 'M', 1);
      await orderService.placeOrder(
        userId: 'user2',
        cartManager: cartManager,
        shippingAddress: '456 Test Ave',
      );

      final user1Orders = orderService.getUserOrders('user1');
      final user2Orders = orderService.getUserOrders('user2');

      expect(user1Orders.length, equals(1));
      expect(user2Orders.length, equals(1));
      expect(user1Orders[0].userId, equals('user1'));
      expect(user2Orders[0].userId, equals('user2'));
    });

    test('should return total order count', () async {
      const product = Product(
        serial: '1',
        name: 'Test Product',
        price: 100.0,
        description: 'Test',
        imageUrl: 'test.jpg',
        category: 'test',
        isSale: false,
      );

      cartManager.addToCart(product, 'M', 1);
      await orderService.placeOrder(
        userId: 'user1',
        cartManager: cartManager,
        shippingAddress: '123 Test St',
      );

      cartManager.addToCart(product, 'M', 1);
      await orderService.placeOrder(
        userId: 'user1',
        cartManager: cartManager,
        shippingAddress: '123 Test St',
      );

      expect(orderService.getTotalOrders('user1'), equals(2));
    });

    test('should return pending order count', () async {
      const product = Product(
        serial: '1',
        name: 'Test Product',
        price: 100.0,
        description: 'Test',
        imageUrl: 'test.jpg',
        category: 'test',
        isSale: false,
      );

      cartManager.addToCart(product, 'M', 1);
      await orderService.placeOrder(
        userId: 'user1',
        cartManager: cartManager,
        shippingAddress: '123 Test St',
      );

      expect(orderService.getPendingOrders('user1'), equals(1));
    });

    test('should notify listeners when order is placed', () async {
      var notified = false;
      orderService.addListener(() {
        notified = true;
      });

      const product = Product(
        serial: '1',
        name: 'Test Product',
        price: 100.0,
        description: 'Test',
        imageUrl: 'test.jpg',
        category: 'test',
        isSale: false,
      );

      cartManager.addToCart(product, 'M', 1);
      await orderService.placeOrder(
        userId: 'user1',
        cartManager: cartManager,
        shippingAddress: '123 Test St',
      );

      expect(notified, isTrue);
    });

    test('should preserve order items with correct data', () async {
      const product = Product(
        serial: '1',
        name: 'Test Product',
        price: 100.0,
        description: 'Test',
        imageUrl: 'test.jpg',
        category: 'test',
        isSale: false,
      );

      cartManager.addToCart(product, 'M', 3);
      final order = await orderService.placeOrder(
        userId: 'user1',
        cartManager: cartManager,
        shippingAddress: '123 Test St',
      );

      final orderItem = order.items[0];
      expect(orderItem.productId, equals('1'));
      expect(orderItem.productName, equals('Test Product'));
      expect(orderItem.size, equals('M'));
      expect(orderItem.quantity, equals(3));
      expect(orderItem.price, equals(100.0));
      expect(orderItem.imageUrl, equals('test.jpg'));
    });

    test('should set custom payment method', () async {
      const product = Product(
        serial: '1',
        name: 'Test Product',
        price: 100.0,
        description: 'Test',
        imageUrl: 'test.jpg',
        category: 'test',
        isSale: false,
      );

      cartManager.addToCart(product, 'M', 1);
      final order = await orderService.placeOrder(
        userId: 'user1',
        cartManager: cartManager,
        shippingAddress: '123 Test St',
        paymentMethod: 'PayPal',
      );

      expect(order.paymentMethod, equals('PayPal'));
    });

    test('should use default payment method', () async {
      const product = Product(
        serial: '1',
        name: 'Test Product',
        price: 100.0,
        description: 'Test',
        imageUrl: 'test.jpg',
        category: 'test',
        isSale: false,
      );

      cartManager.addToCart(product, 'M', 1);
      final order = await orderService.placeOrder(
        userId: 'user1',
        cartManager: cartManager,
        shippingAddress: '123 Test St',
      );

      expect(order.paymentMethod, equals('Credit Card'));
    });
  });

  group('OrderModel Tests', () {
    test('should create OrderModel from JSON', () {
      final json = {
        'id': 'ORDER-123',
        'userId': 'user1',
        'items': [
          {
            'productId': '1',
            'productName': 'Test Product',
            'size': 'M',
            'quantity': 2,
            'price': 100.0,
            'imageUrl': 'test.jpg',
          }
        ],
        'totalAmount': 200.0,
        'status': 'processing',
        'orderDate': DateTime.now().toIso8601String(),
        'trackingNumber': 'TRK-123',
        'shippingAddress': '123 Test St',
        'paymentMethod': 'Credit Card',
      };

      final order = OrderModel.fromJson(json);

      expect(order.id, equals('ORDER-123'));
      expect(order.userId, equals('user1'));
      expect(order.items.length, equals(1));
      expect(order.totalAmount, equals(200.0));
      expect(order.status, equals('processing'));
      expect(order.trackingNumber, equals('TRK-123'));
      expect(order.shippingAddress, equals('123 Test St'));
      expect(order.paymentMethod, equals('Credit Card'));
    });

    test('should convert OrderModel to JSON', () {
      final order = OrderModel(
        id: 'ORDER-123',
        userId: 'user1',
        items: [
          OrderItem(
            productId: '1',
            productName: 'Test Product',
            size: 'M',
            quantity: 2,
            price: 100.0,
            imageUrl: 'test.jpg',
          )
        ],
        totalAmount: 200.0,
        status: 'processing',
        orderDate: DateTime.now(),
        trackingNumber: 'TRK-123',
        shippingAddress: '123 Test St',
        paymentMethod: 'Credit Card',
      );

      final json = order.toJson();

      expect(json['id'], equals('ORDER-123'));
      expect(json['userId'], equals('user1'));
      expect(json['items'], isA<List>());
      expect(json['totalAmount'], equals(200.0));
      expect(json['status'], equals('processing'));
      expect(json['trackingNumber'], equals('TRK-123'));
      expect(json['shippingAddress'], equals('123 Test St'));
      expect(json['paymentMethod'], equals('Credit Card'));
    });

    test('should create OrderItem from JSON', () {
      final json = {
        'productId': '1',
        'productName': 'Test Product',
        'size': 'M',
        'quantity': 2,
        'price': 100.0,
        'imageUrl': 'test.jpg',
      };

      final item = OrderItem.fromJson(json);

      expect(item.productId, equals('1'));
      expect(item.productName, equals('Test Product'));
      expect(item.size, equals('M'));
      expect(item.quantity, equals(2));
      expect(item.price, equals(100.0));
      expect(item.imageUrl, equals('test.jpg'));
    });

    test('should convert OrderItem to JSON', () {
      final item = OrderItem(
        productId: '1',
        productName: 'Test Product',
        size: 'M',
        quantity: 2,
        price: 100.0,
        imageUrl: 'test.jpg',
      );

      final json = item.toJson();

      expect(json['productId'], equals('1'));
      expect(json['productName'], equals('Test Product'));
      expect(json['size'], equals('M'));
      expect(json['quantity'], equals(2));
      expect(json['price'], equals(100.0));
      expect(json['imageUrl'], equals('test.jpg'));
    });
  });
}
