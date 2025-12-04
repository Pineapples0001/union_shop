import 'package:flutter/foundation.dart';
import 'package:union_shop/models/user_model.dart';

class AuthService extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;

  // Simulate email/password login
  Future<bool> loginWithEmail(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // For demo purposes, accept any email/password
    if (email.isNotEmpty && password.length >= 6) {
      _currentUser = UserModel(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        name: email.split('@')[0],
        email: email,
        createdAt: DateTime.now(),
        authProvider: 'email',
      );
      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  // Simulate email/password signup
  Future<bool> signupWithEmail(
      String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    _currentUser = UserModel(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      createdAt: DateTime.now(),
      authProvider: 'email',
    );

    _isLoading = false;
    notifyListeners();
    return true;
  }

  // Simulate Google Sign In
  Future<bool> signInWithGoogle() async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    _currentUser = UserModel(
      id: 'google_${DateTime.now().millisecondsSinceEpoch}',
      name: 'Google User',
      email: 'googleuser@gmail.com',
      photoUrl:
          'https://ui-avatars.com/api/?name=Google+User&background=4285F4&color=fff',
      createdAt: DateTime.now(),
      authProvider: 'google',
    );

    _isLoading = false;
    notifyListeners();
    return true;
  }

  // Simulate Facebook Sign In
  Future<bool> signInWithFacebook() async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    _currentUser = UserModel(
      id: 'facebook_${DateTime.now().millisecondsSinceEpoch}',
      name: 'Facebook User',
      email: 'facebookuser@fb.com',
      photoUrl:
          'https://ui-avatars.com/api/?name=Facebook+User&background=1877F2&color=fff',
      createdAt: DateTime.now(),
      authProvider: 'facebook',
    );

    _isLoading = false;
    notifyListeners();
    return true;
  }

  // Update user profile
  Future<bool> updateProfile(UserModel updatedUser) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    _currentUser = updatedUser;

    _isLoading = false;
    notifyListeners();
    return true;
  }

  // Change password
  Future<bool> changePassword(
      String currentPassword, String newPassword) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    // For demo, always succeed
    _isLoading = false;
    notifyListeners();
    return true;
  }

  // Logout
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 300));

    _currentUser = null;

    _isLoading = false;
    notifyListeners();
  }

  // Reset password
  Future<bool> resetPassword(String email) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    _isLoading = false;
    notifyListeners();
    return true;
  }
}
