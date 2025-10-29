import 'package:flutter/material.dart'; // Import jika belum ada

class User {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String? address;
  final String? gender;
  final DateTime? birthDate; // ✅ 1. TAMBAHKAN FIELD INI
  final String? jobStatus;
  final String? photoPath;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    this.address,
    this.gender,
    this.birthDate, // ✅ 2. TAMBAHKAN KE KONSTRUKTOR
    this.jobStatus,
    this.photoPath,
  });

  // ✅ 3. TAMBAHKAN KE METHOD copyWith
  User copyWith({
    String? name,
    String? email,
    String? password,
    String? phoneNumber,
    String? address,
    String? gender,
    DateTime? birthDate, // <-- Tambahkan di sini
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
      birthDate: birthDate ?? this.birthDate, // <-- Gunakan di sini
      jobStatus: jobStatus ?? this.jobStatus,
      photoPath: photoPath ?? this.photoPath,
    );
  }

  // ✅ 4. TAMBAHKAN KE factory .fromJson (jika Anda menggunakannya)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? 'No Name',
      email: json['email'] ?? 'No Email',
      password: '',
      phoneNumber: json['phone_number'] ?? '',
      address: json['address'],
      gender: json['gender'],
      // Cek jika 'birth_date' ada dan parse, jika tidak null
      birthDate: json['birth_date'] != null
          ? DateTime.tryParse(json['birth_date']) // Gunakan tryParse agar lebih aman
          : null, // <-- Tambahkan parsing di sini
      jobStatus: json['job_status'],
      photoPath: json['photo_path'],
    );
  }

  // Opsional: Tambahkan method toJson jika Anda perlu mengirim data User ke API
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'address': address,
      'gender': gender,
      // Format DateTime ke String ISO 8601 (format standar)
      'birth_date': birthDate?.toIso8601String(), // <-- Tambahkan format di sini
      'job_status': jobStatus,
      'photo_path': photoPath,
      // Jangan sertakan password
    };
  }
}