import 'package:flutter/material.dart'; // Dibutuhkan jika Anda menambahkan ChangeNotifier nanti
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../auth/services/auth_service.dart'; // Untuk mengambil token
import '../models/banner_model.dart'; // Pastikan path ini benar
import '../models/class_model.dart'; // Pastikan path ini benar

class HomeService {
  // ✅ GUNAKAN URL API BARU ANDA
  final String _baseUrl = "https://ls-lms.zoidify.my.id/";

  /// Mengambil daftar banner dari API
  Future<List<BannerModel>> fetchBanners(AuthService auth) async {
    // Tentukan endpoint API untuk banner (sesuaikan jika berbeda)
    final Uri endpoint = Uri.parse("${_baseUrl}banners"); // Contoh endpoint: /banners

    try {
      final response = await http.get(
        endpoint,
        // Tambahkan header Authorization jika API banners memerlukannya
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer ${auth.token}', // Uncomment jika perlu token
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        // Pastikan BannerModel punya factory constructor .fromJson
        return data.map((json) => BannerModel.fromJson(json)).toList();
      } else {
        // Tangani error dari server
        throw Exception(
            'Gagal memuat banners: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      // Tangani error koneksi atau parsing
      print("Error fetching banners: $e");
      throw Exception('Tidak dapat terhubung ke server banner.');
    }
  }

  /// Mengambil daftar kelas populer dari API
  Future<List<ClassModel>> fetchPopularCourses(AuthService auth) async {
    // Tentukan endpoint API untuk kelas populer (sesuaikan jika berbeda)
    final Uri endpoint =
        Uri.parse("${_baseUrl}popular-courses"); // Contoh endpoint: /popular-courses

    try {
      final response = await http.get(
        endpoint,
        // Tambahkan header Authorization jika API kelas populer memerlukannya
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer ${auth.token}', // Uncomment jika perlu token
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
         // Pastikan ClassModel punya factory constructor .fromJson
        return data.map((json) => ClassModel.fromJson(json)).toList();
      } else {
        // Tangani error dari server
        throw Exception(
            'Gagal memuat kelas populer: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      // Tangani error koneksi atau parsing
      print("Error fetching popular courses: $e");
      throw Exception('Tidak dapat terhubung ke server kelas.');
    }
  }

  // Anda bisa menambahkan method lain di sini jika diperlukan (misal: fetchCategories)
}