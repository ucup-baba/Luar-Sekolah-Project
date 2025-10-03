import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Luarsekolah App',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // BAGIAN 1: BACKGROUND HEADER HIJAU (masih kosong)
            Container(
              color: const Color(0xFF0EA781),
              // Kita beri tinggi sementara agar terlihat
              height: 165, 
            ),

            // BAGIAN 2: KONTEN UTAMA DENGAN BACKGROUND PUTIH (masih kosong)
            Transform.translate(
              offset: const Offset(0, -20), // Menarik konten ke atas
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
                    // Semua konten lainnya akan ditambahkan di sini
                    SizedBox(height: 1000), // Placeholder agar bisa scroll
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}