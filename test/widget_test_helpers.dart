import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/services/order_service.dart';

/// Helper function to wrap widgets with required providers for testing
Widget createTestWidget(Widget child,
    {AuthService? authService, OrderService? orderService}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthService>(
        create: (_) => authService ?? AuthService(),
      ),
      ChangeNotifierProvider<OrderService>(
        create: (_) => orderService ?? OrderService(),
      ),
    ],
    child: MaterialApp(
      home: child,
    ),
  );
}
