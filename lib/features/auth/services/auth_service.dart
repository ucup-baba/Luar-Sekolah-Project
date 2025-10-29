import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user_model.dart';

class AuthService with ChangeNotifier {
  User? _loggedInUser;
  String _token = '';

  User? get loggedInUser => _loggedInUser;
  String get token => _token;

  // ✅ URL dasar API kamu
  final String _baseUrl = "https://ls-lms.zoidify.my.id/api";

  // -----------------------
  // 🧾 REGISTER
  // -----------------------
  Future<bool> register(User newUser) async {
    _log("Mencoba register API untuk: ${newUser.email}");
    final Uri endpoint = Uri.parse("$_baseUrl/auth/sign-up/email");

    try {
      final response = await http.post(
        endpoint,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'name': newUser.name,
          'email': newUser.email,
          'password': newUser.password,
          'phone_number': newUser.phoneNumber,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _log("✅ Registrasi API berhasil");
        return true;
      } else {
        _log("❌ Registrasi gagal (${response.statusCode}): ${response.body}");
        return false;
      }
    } catch (e) {
      _log("⚠️ Terjadi error saat registrasi: $e");
      return false;
    }
  }

  // -----------------------
  // 🔑 LOGIN
  // -----------------------
  Future<User?> login(String email, String password) async {
    _log("Mencoba login API dengan email: $email");
    final Uri endpoint = Uri.parse("$_baseUrl/auth/sign-in/email");

    try {
      final response = await http.post(
        endpoint,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        _log("✅ Login API berhasil");
        final data = jsonDecode(response.body);

        // Aman untuk berbagai format respons
        final userData = data['user'] ?? data;
        _loggedInUser = User.fromJson(userData);
        _token = data['token'] ?? '';

        // Simpan token ke lokal
        await _saveToken(_token);
        notifyListeners();
        return _loggedInUser;
      } else {
        _log("❌ Login gagal (${response.statusCode}): ${response.body}");
        _loggedInUser = null;
        _token = '';
        notifyListeners();
        return null;
      }
    } catch (e) {
      _log("⚠️ Terjadi error saat login: $e");
      _loggedInUser = null;
      _token = '';
      notifyListeners();
      return null;
    }
  }

  // -----------------------
  // ⚙️ UPDATE USER
  // -----------------------
  Future<void> updateUser(User updatedUser) async {
    final Uri endpoint = Uri.parse("$_baseUrl/update-user");

    if (_token.isEmpty) {
      _log("❌ Tidak ada token untuk update user.");
      return;
    }

    try {
      final response = await http.put(
        endpoint,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_token',
        },
        body: jsonEncode(updatedUser.toJson()),
      );

      if (response.statusCode == 200) {
        _log("✅ Update user API berhasil");
        _loggedInUser = updatedUser;
        notifyListeners();
      } else {
        _log("❌ Update user API gagal: ${response.body}");
      }
    } catch (e) {
      _log("⚠️ Terjadi error saat update user: $e");
    }
  }

  // -----------------------
  // 🚪 LOGOUT
  // -----------------------
  Future<void> logout() async {
    _loggedInUser = null;
    _token = '';
    await _clearToken();
    _log("👋 User logged out");
    notifyListeners();
  }

  // -----------------------
  // 💾 TOKEN MANAGEMENT
  // -----------------------
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('auth_token') ?? '';
  }

  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  // -----------------------
  // 🧭 UTIL
  // -----------------------
  void _log(String msg) => debugPrint('[AuthService] $msg');
}

// Singleton agar mudah diakses
final authService = AuthService();
