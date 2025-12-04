import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/login_page.dart';
import 'package:union_shop/signup_page.dart';
import 'package:union_shop/account_dashboard.dart';
import 'package:union_shop/all_products_page.dart';
import 'package:union_shop/collections_page.dart';
import 'package:union_shop/category_page.dart';
import 'package:union_shop/cart_page.dart';
import 'package:union_shop/about_page.dart';
import 'package:union_shop/sales_page.dart';

class AppRouter {
  final AuthService authService;

  AppRouter(this.authService);

  late final GoRouter router = GoRouter(
    refreshListenable: authService,
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => LoginPage(authService: authService),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => SignupPage(authService: authService),
      ),
      GoRoute(
        path: '/account',
        name: 'account',
        builder: (context, state) => AccountDashboard(authService: authService),
        redirect: (context, state) {
          if (!authService.isAuthenticated) {
            return '/login';
          }
          return null;
        },
      ),
      GoRoute(
        path: '/all_products',
        name: 'all_products',
        builder: (context, state) {
          final searchQuery = state.uri.queryParameters['searchQuery'] ?? '';
          final category = state.uri.queryParameters['category'];
          return AllProductsPage(
            searchQuery: searchQuery,
            initialCategory: category,
          );
        },
      ),
      GoRoute(
        path: '/collections',
        name: 'collections',
        builder: (context, state) => const CollectionsPage(),
      ),
      GoRoute(
        path: '/category/:categoryName',
        name: 'category',
        builder: (context, state) {
          final categoryName = state.pathParameters['categoryName']!;
          return CategoryPage(categoryName: categoryName);
        },
      ),
      GoRoute(
        path: '/cart',
        name: 'cart',
        builder: (context, state) => const CartPage(),
      ),
      GoRoute(
        path: '/about',
        name: 'about',
        builder: (context, state) => const AboutPage(),
      ),
      GoRoute(
        path: '/sales',
        name: 'sales',
        builder: (context, state) => const SalesPage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found: ${state.uri.path}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}
