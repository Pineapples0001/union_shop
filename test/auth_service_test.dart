import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('AuthService Tests', () {
    late AuthService authService;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      authService = AuthService();
      // Wait for initialization
      await Future.delayed(const Duration(milliseconds: 100));
    });

    test('should initialize with no user', () {
      expect(authService.isAuthenticated, isFalse);
      expect(authService.currentUser, isNull);
      expect(authService.isInitialized, isTrue);
    });

    test('should login with email successfully', () async {
      final result = await authService.loginWithEmail(
        'test@example.com',
        'password123',
      );

      expect(result, isTrue);
      expect(authService.isAuthenticated, isTrue);
      expect(authService.currentUser, isNotNull);
      expect(authService.currentUser!.email, equals('test@example.com'));
    });

    test('should fail login with empty email', () async {
      final result = await authService.loginWithEmail('', 'password123');
      expect(result, isFalse);
      expect(authService.isAuthenticated, isFalse);
    });

    test('should fail login with empty password', () async {
      final result = await authService.loginWithEmail('test@example.com', '');
      expect(result, isFalse);
      expect(authService.isAuthenticated, isFalse);
    });

    test('should signup with email successfully', () async {
      final result = await authService.signupWithEmail(
        'John Doe',
        'john@example.com',
        'password123',
      );

      expect(result, isTrue);
      expect(authService.isAuthenticated, isTrue);
      expect(authService.currentUser, isNotNull);
      expect(authService.currentUser!.name, equals('John Doe'));
      expect(authService.currentUser!.email, equals('john@example.com'));
    });

    test('should signup even with empty name (no validation)', () async {
      final result = await authService.signupWithEmail(
        '',
        'john@example.com',
        'password123',
      );
      // Current implementation doesn't validate inputs
      expect(result, isTrue);
      expect(authService.isAuthenticated, isTrue);
    });

    test('should signup even with empty email (no validation)', () async {
      final result = await authService.signupWithEmail(
        'John Doe',
        '',
        'password123',
      );
      // Current implementation doesn't validate inputs
      expect(result, isTrue);
      expect(authService.isAuthenticated, isTrue);
    });

    test('should signup even with empty password (no validation)', () async {
      final result = await authService.signupWithEmail(
        'John Doe',
        'john@example.com',
        '',
      );
      // Current implementation doesn't validate inputs
      expect(result, isTrue);
      expect(authService.isAuthenticated, isTrue);
    });

    test('should login with Google successfully', () async {
      final result = await authService.signInWithGoogle();

      expect(result, isTrue);
      expect(authService.isAuthenticated, isTrue);
      expect(authService.currentUser, isNotNull);
      expect(authService.currentUser!.name, contains('Google'));
    });

    test('should login with Facebook successfully', () async {
      final result = await authService.signInWithFacebook();

      expect(result, isTrue);
      expect(authService.isAuthenticated, isTrue);
      expect(authService.currentUser, isNotNull);
      expect(authService.currentUser!.name, contains('Facebook'));
    });

    test('should logout successfully', () async {
      await authService.loginWithEmail('test@example.com', 'password123');
      expect(authService.isAuthenticated, isTrue);

      await authService.logout();

      expect(authService.isAuthenticated, isFalse);
      expect(authService.currentUser, isNull);
    });

    test('should persist user data after login', () async {
      await authService.loginWithEmail('test@example.com', 'password123');

      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString('current_user');

      expect(userData, isNotNull);
    });
    test('should clear user data after logout', () async {
      await authService.loginWithEmail('test@example.com', 'password123');
      await authService.logout();

      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString('current_user');

      expect(userData, isNull);
    });

    test('should load user from storage on initialization', () async {
      // First login to save data
      await authService.loginWithEmail('test@example.com', 'password123');

      // Create new instance which should load from storage
      final newAuthService = AuthService();
      await Future.delayed(const Duration(milliseconds: 100));

      expect(newAuthService.isAuthenticated, isTrue);
      expect(newAuthService.currentUser, isNotNull);
      expect(newAuthService.currentUser!.email, equals('test@example.com'));
    });
  });

  group('UserModel Tests', () {
    test('should create UserModel from JSON', () {
      final json = {
        'id': '123',
        'name': 'John Doe',
        'email': 'john@example.com',
        'phoneNumber': '1234567890',
        'address': '123 Main St',
        'city': 'New York',
        'postalCode': '10001',
        'country': 'USA',
        'photoUrl': 'http://example.com/photo.jpg',
        'createdAt': DateTime.now().toIso8601String(),
        'authProvider': 'email',
      };

      final user = UserModel.fromJson(json);

      expect(user.id, equals('123'));
      expect(user.name, equals('John Doe'));
      expect(user.email, equals('john@example.com'));
      expect(user.phoneNumber, equals('1234567890'));
      expect(user.address, equals('123 Main St'));
      expect(user.city, equals('New York'));
      expect(user.postalCode, equals('10001'));
      expect(user.country, equals('USA'));
      expect(user.photoUrl, equals('http://example.com/photo.jpg'));
      expect(user.authProvider, equals('email'));
    });

    test('should convert UserModel to JSON', () {
      final user = UserModel(
        id: '123',
        name: 'John Doe',
        email: 'john@example.com',
        phoneNumber: '1234567890',
        address: '123 Main St',
        city: 'New York',
        postalCode: '10001',
        country: 'USA',
        photoUrl: 'http://example.com/photo.jpg',
        createdAt: DateTime.now(),
        authProvider: 'email',
      );

      final json = user.toJson();

      expect(json['id'], equals('123'));
      expect(json['name'], equals('John Doe'));
      expect(json['email'], equals('john@example.com'));
      expect(json['phoneNumber'], equals('1234567890'));
      expect(json['address'], equals('123 Main St'));
      expect(json['city'], equals('New York'));
      expect(json['postalCode'], equals('10001'));
      expect(json['country'], equals('USA'));
      expect(json['photoUrl'], equals('http://example.com/photo.jpg'));
      expect(json['authProvider'], equals('email'));
    });

    test('should handle null values in UserModel', () {
      final user = UserModel(
        id: '123',
        name: 'John Doe',
        email: 'john@example.com',
        createdAt: DateTime.now(),
        authProvider: 'email',
      );

      expect(user.phoneNumber, isNull);
      expect(user.address, isNull);
      expect(user.city, isNull);
      expect(user.postalCode, isNull);
      expect(user.country, isNull);
      expect(user.photoUrl, isNull);

      final json = user.toJson();
      expect(json['phoneNumber'], isNull);
    });
  });
}
