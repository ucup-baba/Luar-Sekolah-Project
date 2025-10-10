import 'package:flutter/material.dart';
import '../widget/banner_carousel.dart';
import '../widget/home_header.dart';
import '../widget/popular_class_section.dart';
import '../widget/program_section.dart';
import '../widget/voucher_card.dart';
import '../../auth/services/auth_service.dart';
import '../../profile/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // 1. BUAT METHOD _buildHomeContent DI SINI
  // Isinya adalah semua kode UI yang sebelumnya ada di body Scaffold
  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Memanggil widget Header
          HomeHeader(user: widget.user),
          Transform.translate(
            offset: const Offset(0, -20),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Memanggil widget-widget lain
                  BannerCarousel(),
                  SizedBox(height: 24),
                  Text(
                    'Program dari Luarsekolah',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 16),
                  ProgramSection(),
                  SizedBox(height: 24),
                  VoucherCard(),
                  SizedBox(height: 24),
                  Text(
                    'Kelas Terpopuler di Prakerja',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 16),
                  PopularClassSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Definisikan daftar halaman
    final List<Widget> pages = [
      _buildHomeContent(), // Panggil method yang baru dibuat (indeks 0)
      const Center(child: Text('Halaman Kelas')),   // Placeholder (indeks 1)
      const Center(child: Text('Halaman Kelasku')), // Placeholder (indeks 2)
      const Center(child: Text('Halaman koinLS')),  // Placeholder (indeks 3)
      const ProfileScreen(),             // Halaman Akun (indeks 4)
    ];

    // 2. GUNAKAN 'pages' UNTUK SATU-SATUNYA BODY
    return Scaffold(
      body: pages[_currentIndex], // Hanya ada satu body di sini
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  BottomNavigationBar _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      selectedItemColor: const Color(0xFF0EA781),
      unselectedItemColor: const Color(0xFF6C6F70),
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined), label: 'Beranda'),
        BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined), label: 'Kelas'),
        BottomNavigationBarItem(
            icon: Icon(Icons.video_library_outlined), label: 'Kelasku'),
        BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on_outlined), label: 'koinLS'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: 'Akun'),
      ],
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}