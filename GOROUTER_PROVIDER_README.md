# GoRouter and Provider Integration

## Overview

The Union Shop app has been upgraded to use **GoRouter** for navigation and **Provider** for state management, replacing the traditional Navigator and manual state handling.

## Packages Added

```yaml
dependencies:
  go_router: ^14.6.2
  provider: ^6.1.2
```

## Architecture Changes

### 1. **Provider State Management**

#### Main App Setup (`main.dart`):

```dart
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: const UnionShopApp(),
    ),
  );
}
```

#### Benefits:

- **Global State**: AuthService is accessible throughout the app
- **Reactive Updates**: UI automatically rebuilds when auth state changes
- **No Prop Drilling**: No need to pass AuthService through constructor parameters
- **Memory Efficient**: Single instance of AuthService across the app

#### AuthService as ChangeNotifier:

```dart
class AuthService extends ChangeNotifier {
  UserModel? _currentUser;

  // Notify listeners when state changes
  Future<bool> loginWithEmail(String email, String password) async {
    // ... login logic
    notifyListeners(); // Triggers UI rebuild
    return true;
  }
}
```

### 2. **GoRouter Navigation**

#### Router Configuration (`lib/router/app_router.dart`):

```dart
class AppRouter {
  final AuthService authService;

  late final GoRouter router = GoRouter(
    refreshListenable: authService, // Rebuilds routes when auth changes
    routes: [
      GoRoute(path: '/', name: 'home', builder: ...),
      GoRoute(path: '/login', name: 'login', builder: ...),
      GoRoute(
        path: '/account',
        name: 'account',
        redirect: (context, state) {
          // Protected route - redirects if not authenticated
          if (!authService.isAuthenticated) return '/login';
          return null;
        },
      ),
      // ... more routes
    ],
  );
}
```

#### Route Definitions:

| Route        | Path                      | Protected | Parameters                    |
| ------------ | ------------------------- | --------- | ----------------------------- |
| Home         | `/`                       | No        | -                             |
| Login        | `/login`                  | No        | -                             |
| Signup       | `/signup`                 | No        | -                             |
| Account      | `/account`                | **Yes**   | -                             |
| All Products | `/all_products`           | No        | `?searchQuery=`, `?category=` |
| Collections  | `/collections`            | No        | -                             |
| Category     | `/category/:categoryName` | No        | `:categoryName` path param    |
| Cart         | `/cart`                   | No        | -                             |
| About        | `/about`                  | No        | -                             |
| Sales        | `/sales`                  | No        | -                             |

## Navigation Methods

### Declarative Navigation with GoRouter:

#### 1. **Simple Navigation** (context.go):

```dart
// Replaces: Navigator.pushNamed(context, '/login')
context.go('/login');

// Navigate home
context.go('/');
```

#### 2. **Navigation with Query Parameters**:

```dart
// Search with query
context.go('/all_products?searchQuery=${Uri.encodeComponent(searchText)}');

// Multiple parameters
context.go('/all_products?searchQuery=hoodie&category=Clothing');
```

#### 3. **Navigation with Path Parameters**:

```dart
// Category page
context.go('/category/${Uri.encodeComponent(categoryName)}');
```

#### 4. **Stack-based Navigation** (when needed):

```dart
// For ProductPage which needs product object
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ProductPage(product: product),
  ),
);
```

### Migration from Navigator to GoRouter:

| Old (Navigator)                                                         | New (GoRouter)                     |
| ----------------------------------------------------------------------- | ---------------------------------- |
| `Navigator.pushNamed(context, '/login')`                                | `context.go('/login')`             |
| `Navigator.pushNamed(context, '/products', arguments: {'q': 'search'})` | `context.go('/products?q=search')` |
| `Navigator.pushReplacementNamed(context, '/')`                          | `context.go('/')`                  |
| `Navigator.pop(context)`                                                | `context.pop()`                    |

## Key Features

### 1. **Protected Routes**

Routes like `/account` automatically redirect to `/login` if user is not authenticated:

```dart
GoRoute(
  path: '/account',
  redirect: (context, state) {
    if (!authService.isAuthenticated) return '/login';
    return null;
  },
)
```

### 2. **Auto Refresh on Auth Changes**

The router listens to AuthService and rebuilds when authentication state changes:

```dart
GoRouter(
  refreshListenable: authService, // Listens to notifyListeners()
  // ...
)
```

### 3. **Query Parameter Handling**

Extract parameters from URL:

```dart
// In AllProductsPage route
builder: (context, state) {
  final searchQuery = state.uri.queryParameters['searchQuery'] ?? '';
  final category = state.uri.queryParameters['category'];
  return AllProductsPage(searchQuery: searchQuery, initialCategory: category);
}
```

### 4. **Path Parameter Handling**

Extract dynamic path segments:

```dart
// In Category route
builder: (context, state) {
  final categoryName = state.pathParameters['categoryName']!;
  return CategoryPage(categoryName: categoryName);
}
```

### 5. **Error Handling**

Custom 404 page:

```dart
errorBuilder: (context, state) => Scaffold(
  body: Center(
    child: Column(
      children: [
        Text('Page not found: ${state.uri.path}'),
        ElevatedButton(
          onPressed: () => context.go('/'),
          child: Text('Go Home'),
        ),
      ],
    ),
  ),
)
```

## Provider Usage Patterns

### 1. **Accessing AuthService**:

#### In Widget Build Method:

```dart
@override
Widget build(BuildContext context) {
  final authService = Provider.of<AuthService>(context, listen: false);
  // Use authService
}
```

#### With Consumer (for reactive updates):

```dart
Consumer<AuthService>(
  builder: (context, authService, child) {
    if (authService.isAuthenticated) {
      return Text('Welcome ${authService.currentUser?.name}');
    }
    return Text('Please login');
  },
)
```

### 2. **State Updates Trigger UI Rebuild**:

```dart
// In AuthService
await loginWithEmail(email, password);
notifyListeners(); // All listening widgets rebuild
```

## Benefits of This Architecture

### GoRouter Benefits:

1. **Type Safety**: Compile-time route checking
2. **Deep Linking**: Full URL support for web
3. **Browser Integration**: Back/forward buttons work correctly on web
4. **Declarative**: Routes defined in one place
5. **Redirects**: Built-in redirect logic for protected routes
6. **Path/Query Parameters**: Clean URL parameter handling

### Provider Benefits:

1. **Simplicity**: Easy to understand and use
2. **Performance**: Rebuilds only necessary widgets
3. **Testability**: Easy to mock and test
4. **Scalability**: Can add more providers as app grows
5. **InheritedWidget**: Built on Flutter's efficient InheritedWidget

## Testing

### Test Navigation:

```dart
// Test protected route redirect
testWidgets('redirects to login when not authenticated', (tester) async {
  await tester.pumpWidget(MyApp());

  // Try to navigate to /account
  router.go('/account');
  await tester.pumpAndSettle();

  // Should be on login page
  expect(find.text('Login'), findsOneWidget);
});
```

### Test Provider:

```dart
testWidgets('shows user name when logged in', (tester) async {
  final authService = AuthService();
  await authService.loginWithEmail('test@example.com', 'password');

  await tester.pumpWidget(
    ChangeNotifierProvider.value(
      value: authService,
      child: MyApp(),
    ),
  );

  expect(find.text('test'), findsOneWidget);
});
```

## Migration Checklist

✅ **Completed**:

- [x] Added go_router and provider packages
- [x] Created AppRouter with all routes
- [x] Wrapped app with MultiProvider
- [x] Updated all Navigator.pushNamed to context.go
- [x] Updated search dialogs to use query parameters
- [x] Updated authentication redirects
- [x] Added protected route logic
- [x] Updated all page imports
- [x] Removed old onGenerateRoute logic
- [x] Updated MaterialApp to MaterialApp.router

## Future Enhancements

### Additional Providers:

```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => AuthService()),
    ChangeNotifierProvider(create: (_) => CartService()),
    ChangeNotifierProvider(create: (_) => ThemeService()),
  ],
  child: const UnionShopApp(),
)
```

### Nested Routes:

```dart
GoRoute(
  path: '/account',
  builder: (context, state) => AccountLayout(),
  routes: [
    GoRoute(path: 'profile', builder: (context, state) => ProfilePage()),
    GoRoute(path: 'orders', builder: (context, state) => OrdersPage()),
    GoRoute(path: 'settings', builder: (context, state) => SettingsPage()),
  ],
)
```

### Route Transitions:

```dart
GoRoute(
  path: '/product/:id',
  pageBuilder: (context, state) => CustomTransitionPage(
    key: state.pageKey,
    child: ProductPage(id: state.pathParameters['id']!),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  ),
)
```

## Debugging

Enable router logging:

```dart
GoRouter(
  debugLogDiagnostics: true, // Logs all navigation events
  // ...
)
```

Check current route:

```dart
final location = GoRouterState.of(context).uri.toString();
print('Current route: $location');
```

## Common Patterns

### 1. Navigate and Clear Stack:

```dart
context.go('/'); // Always clears stack to root
```

### 2. Navigate with Data:

```dart
// Pass via query params
context.go('/search?query=hoodie&category=clothing');

// Or use extra parameter (doesn't show in URL)
context.push('/details', extra: productObject);
```

### 3. Conditional Navigation:

```dart
final isLoggedIn = Provider.of<AuthService>(context).isAuthenticated;
if (isLoggedIn) {
  context.go('/account');
} else {
  context.go('/login');
}
```

## Resources

- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Provider Documentation](https://pub.dev/packages/provider)
- [Flutter Navigation 2.0](https://docs.flutter.dev/development/ui/navigation)
