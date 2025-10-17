import 'package:flutter/material.dart';

// Import semua widget dan screen yang Anda butuhkan
import '../widget/banner_carousel.dart';
import '../widget/home_header.dart';
import '../widget/popular_class_section.dart';
import '../widget/program_section.dart';
import '../widget/voucher_card.dart';
import '../../profile/screens/profile_screen.dart';
// ✅ 1. IMPORT HALAMAN KELASKU YANG BARU
import '../../kelasku/screens/kelasku_screen.dart'; 


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  int _previousIndex = 0;

  // Method ini hanya untuk konten tab Beranda
  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const HomeHeader(),
          Transform.translate(
            offset: const Offset(0, -20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
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
                  BannerCarousel(),
                  SizedBox(height: 24),
                  Text('Program dari Luarsekolah',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  SizedBox(height: 16),
                  ProgramSection(),
                  SizedBox(height: 24),
                  VoucherCard(),
                  SizedBox(height: 24),
                  Text('Kelas Terpopuler di Prakerja',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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
    // Definisikan daftar halaman untuk Bottom Navigation Bar
    final List<Widget> pages = [
      _buildHomeContent(), // Indeks 0: Beranda
      const Center(child: Text('Halaman Kelas')), // Indeks 1: Kelas (Placeholder)
      const KelaskuScreen(), // ✅ 2. GANTI PLACEHOLDER DENGAN KELASKU SCREEN
      const Center(child: Text('Halaman koinLS')), // Indeks 3: koinLS (Placeholder)
      const ProfileScreen(), // Indeks 4: Akun
    ];

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          final slideRight = _currentIndex > _previousIndex;
          final offsetAnimation = Tween<Offset>(
            begin: Offset(slideRight ? 1.0 : -1.0, 0.0),
            end: Offset.zero,
          ).animate(animation);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        child: Container(
          key: ValueKey<int>(_currentIndex),
          child: pages[_currentIndex],
        ),
      ),
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
          _previousIndex = _currentIndex;
          _currentIndex = index;
        });
      },
    );
  }
}

