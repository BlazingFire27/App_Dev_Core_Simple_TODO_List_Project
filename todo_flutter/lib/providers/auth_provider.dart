import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../model/user.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _user != null;

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void _setError(String? msg) {
    _errorMessage = msg;
    notifyListeners();
  }

  Future<bool> register(String userId, String password) async {
    _setLoading(true);
    _setError(null);

    try {
      final res = await _apiService.registerUser(userId, password);
      print('Register response: $res');

      if (res['message'] == 'User registered successfully') {
        return true;
      } else {
        _setError(res['message'] ?? 'Registration failed');
        return false;
      }
    }
    catch (error) {
      _setError('Registration failed: $error');
      return false;
    }
    finally {
      _setLoading(false);
    }
  }

  Future<bool> login(String userId, String password) async {
    _setLoading(true);
    _setError(null);

    try {
      final res = await _apiService.loginUser(userId, password);
      print('Login response: $res');

      if (res['message'] == 'Login successful' && res['data'] != null) {
        _user = User.fromJson(res['data']);
        notifyListeners();
        return true;
      } else {
        _setError(res['message'] ?? 'Login failed');
        return false;
      }
    }
    catch (error) {
      _setError('Login failed: $error');
      return false;
    }
    finally {
      _setLoading(false);
    }
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
