import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../auth/services/auth_service.dart';
import '../../home/models/my_course_model.dart';
import '../../home/widget/my_course_card.dart';
import '../../home/services/course_service.dart'; // ✅ 1. IMPORT COURSE SERVICE

class KelaskuScreen extends StatelessWidget {
  const KelaskuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ❌ 2. HAPUS DATA DUMMY DARI SINI
    // final List<MyCourseModel> myCourses = [ ... ];

    return DefaultTabController(
      length: 3, // Jumlah tab yang Anda miliki
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          // Consumer untuk nama (ini sudah benar)
          title: Consumer<AuthService>(
            builder: (context, auth, child) {
              final userName = auth.loggedInUser?.name ?? 'Pengguna';
              return Text(
                'Lanjutkan Kembali Progres Belajarmu, $userName.',
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
              );
            },
          ),
          bottom: const TabBar(
            indicatorColor: Color(0xFF0EA781),
            labelColor: Colors.black87,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Kelas Prakerja'),
              Tab(text: 'Kelas SPL'),
              Tab(text: 'Kelas Langganan'),
            ],
          ),
        ),
        // ✅ 3. GUNAKAN 'CONSUMER' UNTUK MENDAPATKAN DAFTAR KELAS
        body: Consumer<CourseService>(
          builder: (context, courseService, child) {
            // Ambil daftar 'myCourses' dari service
            final myCourses = courseService.myCourses;
            
            // Sekarang kita bisa bangun TabBarView dengan data yang benar
            return TabBarView(
              children: [
                // Konten untuk Tab 1 (Kelas Prakerja)
                ListView.builder(
                  padding: const EdgeInsets.all(20.0),
                  itemCount: myCourses.length,
                  itemBuilder: (context, index) {
                    return MyCourseCard(course: myCourses[index]);
                  },
                ),
                // Konten untuk Tab 2 (Kelas SPL)
                const Center(child: Text('Daftar Kelas SPL Anda')),
                // Konten untuk Tab 3 (Kelas Langganan)
                const Center(child: Text('Daftar Kelas Langganan Anda')),
              ],
            );
          },
        ),
      ),
    );
  }
}

