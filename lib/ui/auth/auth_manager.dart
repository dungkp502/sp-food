// auth_manager.dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:foodapp/model/auth_token.dart';
import '../../../services/auth_services.dart';

class AuthManager with ChangeNotifier {
  AuthToken? _authToken;
  Timer? _authTimer;
  String? _userRole; // Added for role

  final AuthService _authService = AuthService();

  bool get isAuth {
    return authToken != null && authToken!.isValid;
  }

  AuthToken? get authToken {
    return _authToken;
  }

  String? get userRole {
    return _userRole;
  }

  void _setAuthToken(AuthToken token, String role) {
    _authToken = token;
    _userRole = role; // Set the role
    _autoLogout();
    notifyListeners();
  }

  Future<void> signup(String email, String password, String phone, String name, String address) async {
    final token = await _authService.signup(email, password, phone, name, address);
    final role = await _authService.loadUserRole();
    _setAuthToken(token, role ?? 'user');
  }

  Future<void> login(String email, String password) async {
    final token = await _authService.login(email, password);
    final role = await _authService.loadUserRole();
    _setAuthToken(token, role ?? 'user');
  }

  Future<bool> tryAutoLogin() async {
    final savedToken = await _authService.loadSavedAuthToken();
    final savedRole = await _authService.loadUserRole();
    if (savedToken == null) {
      return false;
    }

    _setAuthToken(savedToken, savedRole ?? 'user');
    return true;
  }

  // Future<void> logout() async {
  //   _authToken = null;
  //   _userRole = null; // Clear the role
  //   if (_authTimer != null) {
  //     _authTimer!.cancel();
  //     _authTimer = null;
  //   }
  //   notifyListeners();
  //   _authService.clearSavedAuthToken();
  // }
  Future<void> logout() async {
    _authToken = null;
     _userRole = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    _authService.clearSavedAuthToken();
  }
  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _authToken!.expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
