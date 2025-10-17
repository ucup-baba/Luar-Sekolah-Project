import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../auth/services/auth_service.dart';
import '../../home/models/my_course_model.dart';
import '../../home/widget/my_course_card.dart';

class KelaskuScreen extends StatelessWidget {
  const KelaskuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy untuk ditampilkan
    final List<MyCourseModel> myCourses = [
      MyCourseModel(
        imageUrl:
            'https://img.freepik.com/free-photo/arrangement-gardening-tools_23-2148882627.jpg?size=626&ext=jpg&ga=GA1.1.2008272138.1720828800&semt=ais_user',
        title: 'Pembuatan Pestisida Ramah Lingkungan untuk Petani Terampil',
        provider: 'Luarsekolah',
        progress: 0,
      ),
      MyCourseModel(
        imageUrl:
            'https://img.freepik.com/free-photo/mechanic-changing-tires-car-service_1303-26938.jpg?size=626&ext=jpg',
        title: 'Membangun Usaha Bengkel dari Nol hingga Sukses',
        provider: 'Luarsekolah',
        progress: 75,
      ),
    ];

    return DefaultTabController(
      length: 3, // Jumlah tab yang Anda miliki
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          // ✅ GUNAKAN CONSUMER UNTUK MENGAMBIL NAMA PENGGUNA
          title: Consumer<AuthService>(
            builder: (context, auth, child) {
              // Ambil nama pengguna, beri nilai default 'Pengguna' jika belum login
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
        body: TabBarView(
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
            const Center(child: Text('Daftar Klas Langganan Anda')),
          ],
        ),
      ),
    );
  }
}

