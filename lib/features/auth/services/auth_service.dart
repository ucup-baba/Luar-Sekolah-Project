import 'package:flutter/material.dart';

// 1. Model untuk data pengguna
class User {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String? address;
  final String? gender;
  final DateTime? birthDate;
  final String? jobStatus;
  final String? photoPath;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    this.address,
    this.gender,
    this.birthDate,
    this.jobStatus,
    this.photoPath,
  });

  User copyWith({
    String? name,
    String? email,
    String? password,
    String? phoneNumber,
    String? address,
    String? gender,
    DateTime? birthDate,
    String? jobStatus,
    String? photoPath,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      jobStatus: jobStatus ?? this.jobStatus,
      photoPath: photoPath ?? this.photoPath,
    );
  }
}

// 2. Service untuk mengelola autentikasi
class AuthService with ChangeNotifier {
  User? _registeredUser;
  User? _loggedInUser;

  User? get loggedInUser => _loggedInUser;

  Future<bool> register(User newUser) async {
    _registeredUser = newUser;
    return true;
  }

  Future<User?> login(String email, String password) async {
    if (_registeredUser != null &&
        _registeredUser!.email == email &&
        _registeredUser!.password == password) {
      _loggedInUser = _registeredUser;
      return _loggedInUser;
    }
    return null;
  }

  Future<void> updateUser(User updatedUser) async {
    if (_loggedInUser != null) {
      _loggedInUser = updatedUser;

      if (_registeredUser?.email == updatedUser.email) {
        _registeredUser = updatedUser;
      }

      print('Data pengguna diperbarui: ${_loggedInUser!.name}');
      notifyListeners();
    }
  }

  void logout() {
    _loggedInUser = null;
    notifyListeners();
  }
}

// Singleton pattern — hanya satu instance global
final authService = AuthService();
