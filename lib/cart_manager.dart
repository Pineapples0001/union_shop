import 'package:flutter/foundation.dart';
import 'package:union_shop/main.dart';

// Cart Item Model
class CartItem {
  final Product product;
  final String size;
  final int quantity;

  CartItem({
    required this.product,
    required this.size,
    required this.quantity,
  });
}

// Cart Manager - Singleton pattern to manage cart state
class CartManager {
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal();

  final List<CartItem> _cartItems = [];
  final ValueNotifier<int> itemCountNotifier = ValueNotifier<int>(0);

  List<CartItem> get cartItems => List.unmodifiable(_cartItems);

  void addToCart(Product product, String size, int quantity) {
    // Check if item with same product and size already exists
    final existingIndex = _cartItems.indexWhere(
      (item) => item.product.serial == product.serial && item.size == size,
    );

    if (existingIndex != -1) {
      // Update quantity if item exists
      final existingItem = _cartItems[existingIndex];
      _cartItems[existingIndex] = CartItem(
        product: existingItem.product,
        size: existingItem.size,
        quantity: existingItem.quantity + quantity,
      );
    } else {
      // Add new item
      _cartItems.add(CartItem(
        product: product,
        size: size,
        quantity: quantity,
      ));
    }
    itemCountNotifier.value = _cartItems.length;
  }

  void removeFromCart(int index) {
    if (index >= 0 && index < _cartItems.length) {
      _cartItems.removeAt(index);
      itemCountNotifier.value = _cartItems.length;
    }
  }

  void updateQuantity(int index, int newQuantity) {
    if (index >= 0 && index < _cartItems.length && newQuantity > 0) {
      final item = _cartItems[index];
      _cartItems[index] = CartItem(
        product: item.product,
        size: item.size,
        quantity: newQuantity,
      );
    }
  }

  void clearCart() {
    _cartItems.clear();
    itemCountNotifier.value = 0;
  }

  int get itemCount => _cartItems.length;

  double get totalPrice {
    return _cartItems.fold(0.0, (sum, item) {
      final price = item.product.isSale && item.product.salePrice != null
          ? item.product.salePrice!
          : item.product.price;
      return sum + (price * item.quantity);
    });
  }
}
