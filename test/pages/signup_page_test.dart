import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/signup_page.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/services/order_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('SignupPage Tests', () {
    late AuthService authService;
    late OrderService orderService;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      authService = AuthService();
      orderService = OrderService();
      await Future.delayed(const Duration(milliseconds: 100));
    });

    Widget createTestWidget() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthService>.value(value: authService),
          ChangeNotifierProvider<OrderService>.value(value: orderService),
        ],
        child: MaterialApp(
          home: SignupPage(authService: authService),
        ),
      );
    }

    testWidgets('should display signup page elements', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Sign Up'), findsOneWidget);
      expect(find.text('Sign up to start shopping'), findsOneWidget);
      expect(find.text('Full Name'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Sign Up'), findsOneWidget);
    });

    testWidgets('should display social signup buttons', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Sign up with Google'), findsOneWidget);
      expect(find.text('Sign up with Facebook'), findsOneWidget);
    });

    testWidgets('should display login link', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.textContaining('Already have an account?'), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);
    });

    testWidgets('should show error for empty name', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final signUpButton = find.text('SIGN UP');
      await tester.tap(signUpButton);
      await tester.pumpAndSettle();

      expect(find.text('Please enter your name'), findsOneWidget);
    });

    testWidgets('should show error for invalid email', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final nameField = find.widgetWithText(TextFormField, 'Full Name');
      await tester.enterText(nameField, 'John Doe');

      final emailField = find.widgetWithText(TextFormField, 'Email');
      await tester.enterText(emailField, 'invalidemail');

      final signUpButton = find.text('SIGN UP');
      await tester.tap(signUpButton);
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email'), findsOneWidget);
    });

    testWidgets('should toggle password visibility', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final visibilityIcon = find.byIcon(Icons.visibility_off_outlined);
      expect(visibilityIcon, findsWidgets);

      await tester.tap(visibilityIcon.first);
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.visibility_outlined), findsWidgets);
    });

    testWidgets('should attempt signup with valid data', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final nameField = find.widgetWithText(TextFormField, 'Full Name');
      await tester.enterText(nameField, 'John Doe');

      final emailField = find.widgetWithText(TextFormField, 'Email');
      await tester.enterText(emailField, 'john@example.com');

      final passwordField = find.widgetWithText(TextFormField, 'Password');
      await tester.enterText(passwordField, 'password123');

      final signUpButton = find.text('SIGN UP');
      await tester.tap(signUpButton);
      await tester.pump();

      // Loading indicator shows briefly
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
