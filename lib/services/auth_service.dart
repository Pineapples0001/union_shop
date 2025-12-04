import 'package:flutter/foundation.dart';
import 'package:union_shop/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthService extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;
  bool _isInitialized = false;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;
  bool get isInitialized => _isInitialized;

  AuthService() {
    _loadUserFromStorage();
  }

  Future<void> _loadUserFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('current_user');
      if (kDebugMode) {
        print('🔍 Loading user from storage...');
        print('📦 Found stored user: ${userJson != null}');
      }
      if (userJson != null) {
        _currentUser = UserModel.fromJson(json.decode(userJson));
        if (kDebugMode) {
          print('✅ User loaded: ${_currentUser!.email}');
        }
        notifyListeners();
      } else {
        if (kDebugMode) {
          print('❌ No user in storage');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error loading user from storage: $e');
      }
    } finally {
      _isInitialized = true;
      if (kDebugMode) {
        print('✅ Auth service initialized. Authenticated: $isAuthenticated');
      }
      notifyListeners();
    }
  }

  Future<void> _saveUserToStorage(UserModel user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('current_user', json.encode(user.toJson()));
      if (kDebugMode) {
        print('💾 User saved to storage: ${user.email}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error saving user to storage: $e');
      }
    }
  }

  Future<void> _clearUserFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('current_user');
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing user from storage: $e');
      }
    }
  }

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
      await _saveUserToStorage(_currentUser!);
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

    await _saveUserToStorage(_currentUser!);
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

    await _saveUserToStorage(_currentUser!);
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

    await _saveUserToStorage(_currentUser!);
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
    await _clearUserFromStorage();

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
