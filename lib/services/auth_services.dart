// auth_service.dart
import 'dart:convert';
import 'dart:async';
import 'package:foodapp/model/auth_token.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../model/http_exception.dart';
// import '../models/http_exception.dart';
// import '../models/auth_token.dart';

class AuthService {
  static const _authTokenKey = 'authToken';
  static const _authRoleKey = 'authRole'; // Added for role
  late final String? _apiKey;

  AuthService() {
    _apiKey = dotenv.env['FIREBASE_API_KEY'];
  }

  String _buildAuthUrl(String method) {
    return 'https://identitytoolkit.googleapis.com/v1/accounts:$method?key=$_apiKey';
  }

  Future<AuthToken> _authenticate(String email, String password, String method,
      [String phone = '', String name = '', String address = '']) async {
    try {
      final url = Uri.parse(_buildAuthUrl(method));
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseJson = json.decode(response.body);

      if (responseJson['error'] != null) {
        throw HttpException.firebase(responseJson['error']['message']);
      }

      final authToken = _fromJson(responseJson);

      if (method == 'signUp') {
        final token = authToken.token;
        final uid = authToken.userId;
        final usersUrl = Uri.parse(
            'https://danentangck-default-rtdb.firebaseio.com/users.json?auth=$token');
        final response = await http.post(usersUrl,
            body: json.encode({
              'uid': uid,
              'email': email,
              'name': name,
              'phone': phone,
              'address': address,
              'birthday': '',
              'role': 'user'
            }));
      }

      final role = await isAdmin(authToken);
      authToken.role = role;

      await _saveAuthToken(authToken);
      await _saveUserRole(role); // Save role to SharedPreferences

      return authToken;
    } catch (error) {
      throw Exception('Invalid OTP');
    }
  }

  Future<AuthToken> signup(String email, String password, String phone,
      String name, String address) {
    return _authenticate(email, password, 'signUp', phone, name, address);
  }

  Future<AuthToken> login(String email, String password) {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<String> isAdmin(AuthToken authToken) async {
    final token = authToken.token;
    final uid = authToken.userId;
    final usersUrl = Uri.parse(
        'https://danentangck-default-rtdb.firebaseio.com/users.json?auth=$token&orderBy="uid"&equalTo="$uid"');

    final response = await http.get(usersUrl);
    final user = json.decode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return user[user.keys.first]['role'];
    }

    return 'user';
  }

  Future<void> _saveAuthToken(AuthToken authToken) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_authTokenKey, json.encode(authToken.toJson()));
  }

  Future<void> _saveUserRole(String role) async { // Save role to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_authRoleKey, role);
  }

  AuthToken _fromJson(Map<String, dynamic> json) {
    return AuthToken(
      token: json['idToken'],
      userId: json['localId'],
      expiryDate: DateTime.now().add(
        Duration(
          seconds: int.parse(
            json['expiresIn'],
          ),
        ),
      ),
    );
  }

  Future<AuthToken?> loadSavedAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_authTokenKey)) {
      return null;
    }

    final savedToken = prefs.getString(_authTokenKey);
    final authToken = AuthToken.fromJson(json.decode(savedToken!));
    if (!authToken.isValid) {
      return null;
    }
    return authToken;
  }

  Future<String?> loadUserRole() async { // Load role from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_authRoleKey);
  }

  Future<void> clearSavedAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_authTokenKey);
    prefs.remove(_authRoleKey); // Clear role as well
  }
}
