import 'package:flutter/foundation.dart';
import 'package:union_shop/models/order_model.dart';
import 'package:union_shop/cart_manager.dart';

class OrderService extends ChangeNotifier {
  final List<OrderModel> _orders = [];

  List<OrderModel> get orders => List.unmodifiable(_orders);

  List<OrderModel> getUserOrders(String userId) {
    return _orders.where((order) => order.userId == userId).toList();
  }

  Future<OrderModel> placeOrder({
    required String userId,
    required CartManager cartManager,
    required String shippingAddress,
    String paymentMethod = 'Credit Card',
  }) async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    // Convert cart items to order items
    final orderItems = cartManager.cartItems.map((cartItem) {
      return OrderItem(
        productId: cartItem.product.serial,
        productName: cartItem.product.name,
        size: cartItem.size,
        quantity: cartItem.quantity,
        price: cartItem.product.isSale && cartItem.product.salePrice != null
            ? cartItem.product.salePrice!
            : cartItem.product.price,
        imageUrl: cartItem.product.imageUrl,
      );
    }).toList();

    // Calculate total
    final totalAmount = orderItems.fold<double>(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    // Create order
    final order = OrderModel(
      id: 'ORD${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      items: orderItems,
      totalAmount: totalAmount,
      status: 'processing',
      orderDate: DateTime.now(),
      trackingNumber: 'TRK${DateTime.now().millisecondsSinceEpoch}',
      shippingAddress: shippingAddress,
      paymentMethod: paymentMethod,
    );

    _orders.add(order);

    if (kDebugMode) {
      print('📦 Order placed: ${order.id} for user: $userId');
    }

    notifyListeners();

    return order;
  }

  int getTotalOrders(String userId) {
    return getUserOrders(userId).length;
  }

  int getPendingOrders(String userId) {
    return getUserOrders(userId).where((o) => o.status == 'processing').length;
  }

  int getShippedOrders(String userId) {
    return getUserOrders(userId).where((o) => o.status == 'shipped').length;
  }

  int getDeliveredOrders(String userId) {
    return getUserOrders(userId).where((o) => o.status == 'delivered').length;
  }

  List<OrderModel> getRecentOrders(String userId, {int limit = 3}) {
    final userOrders = getUserOrders(userId);
    userOrders.sort((a, b) => b.orderDate.compareTo(a.orderDate));
    return userOrders.take(limit).toList();
  }
}
