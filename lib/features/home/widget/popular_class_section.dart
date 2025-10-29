import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../auth/services/auth_service.dart';
import '../models/class_model.dart';
import '../services/home_service.dart'; // Pastikan path ini benar
import 'class_card.dart';

class PopularClassSection extends StatefulWidget {
  const PopularClassSection({super.key});

  @override
  State<PopularClassSection> createState() => _PopularClassSectionState();
}

class _PopularClassSectionState extends State<PopularClassSection> {
  // === Bagian API ===
  final HomeService _homeService = HomeService(); // Buat instance service
  late Future<List<ClassModel>> _popularCoursesFuture; // Variabel untuk data API

  @override
  void initState() {
    super.initState();
    // Panggil API saat widget pertama kali dimuat
    // Ambil AuthService untuk mendapatkan token (jika diperlukan oleh API)
    final authService = Provider.of<AuthService>(context, listen: false);
    _popularCoursesFuture = _homeService.fetchPopularCourses(authService);
  }

  @override
  Widget build(BuildContext context) {
    // === Menggunakan FutureBuilder untuk menampilkan data API ===
    return SizedBox(
      height: 290, // Sesuaikan tinggi jika perlu
      child: FutureBuilder<List<ClassModel>>(
        future: _popularCoursesFuture, // Data yang ditunggu
        builder: (context, snapshot) {
          // 1. Saat LOADING
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // 2. Saat terjadi ERROR
          if (snapshot.hasError) {
            // Tampilkan pesan error yang lebih informatif
            print("Error fetching popular courses: ${snapshot.error}"); // Log error
            return Center(child: Text('Gagal memuat kelas: ${snapshot.error}'));
          }
          // 3. Saat DATA SUKSES diterima
          if (snapshot.hasData) {
            final courses = snapshot.data!;
            // Jika data kosong
            if (courses.isEmpty) {
              return const Center(child: Text('Belum ada kelas populer saat ini.'));
            }
            // Jika ada data, tampilkan ListView
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: courses.length,
              itemBuilder: (context, index) {
                // Gunakan ClassCard untuk setiap item
                return ClassCard(course: courses[index]);
              },
            );
          }
          // 4. Fallback jika tidak ada state di atas (seharusnya tidak terjadi)
          return const Center(child: Text('Tidak ada data kelas.'));
        },
      ),
    );
  }
}

