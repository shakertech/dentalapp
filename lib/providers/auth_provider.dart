import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  bool _isAuthenticated = false;
  String? _token;
  Map<String, dynamic>? _user;

  bool get isAuthenticated => _isAuthenticated;
  Map<String, dynamic>? get user => _user;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    if (_token != null) {
      // Validate token or load user profile
      try {
        final data = await _apiService.get('/me');
        _user = data;
        _isAuthenticated = true;
      } catch (e) {
        // Token invalid or expired
        await logout();
      }
    }
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    try {
      final data = await _apiService.post('/login', {
        'email': email,
        'password': password,
      });

      _token = data['token']; // Adjust based on actual API response structure
      _user = data['user']; // Adjust based on actual API response structure

      if (_token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _token!);
        _isAuthenticated = true;
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    try {
      final data = await _apiService.post('/register', {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
      });

      // Auto login after register if API returns token
      _token = data['token'];
      _user = data['user'];

      if (_token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _token!);
        _isAuthenticated = true;
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      // Attempt api logout but clear local state regardless
      await _apiService.post('/logout', {});
    } catch (_) {}

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    _token = null;
    _user = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}
