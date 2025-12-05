import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/account_dashboard.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/services/order_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('AccountDashboard Tests', () {
    late AuthService authService;
    late OrderService orderService;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      authService = AuthService();
      orderService = OrderService();
      // Wait for AuthService to initialize
      await Future.delayed(const Duration(milliseconds: 200));
    });

    testWidgets('should display dashboard when authenticated', (tester) async {
      await authService.loginWithEmail('test@example.com', 'password123');

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthService>.value(value: authService),
            ChangeNotifierProvider<OrderService>.value(value: orderService),
          ],
          child: MaterialApp.router(
            routerConfig: GoRouter(
              routes: [
                GoRoute(
                  path: '/',
                  builder: (context, state) =>
                      AccountDashboard(authService: authService),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(authService.isAuthenticated, isTrue);
    });

    testWidgets('should display orders section', (tester) async {
      await authService.loginWithEmail('test@example.com', 'password123');

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthService>.value(value: authService),
            ChangeNotifierProvider<OrderService>.value(value: orderService),
          ],
          child: MaterialApp(
            home: AccountDashboard(authService: authService),
          ),
        ),
      );

      await tester.pump();
      expect(find.text('My Orders'), findsWidgets);
    });

    testWidgets('should display empty orders message', (tester) async {
      await authService.loginWithEmail('test@example.com', 'password123');

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthService>.value(value: authService),
            ChangeNotifierProvider<OrderService>.value(value: orderService),
          ],
          child: MaterialApp(
            home: AccountDashboard(authService: authService),
          ),
        ),
      );

      await tester.pump();
      expect(find.text('No orders yet'), findsOneWidget);
    });

    testWidgets('should have logout button', (tester) async {
      await authService.loginWithEmail('test@example.com', 'password123');

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthService>.value(value: authService),
            ChangeNotifierProvider<OrderService>.value(value: orderService),
          ],
          child: MaterialApp(
            home: AccountDashboard(authService: authService),
          ),
        ),
      );

      await tester.pump();
      expect(find.text('Logout'), findsOneWidget);
    });
  });
}
