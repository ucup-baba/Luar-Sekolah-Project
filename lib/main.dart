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
  int _currentBannerPage = 0;
  final PageController _bannerController = PageController();
  final int _bannerCount = 3; // Misal ada 3 banner

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menggunakan SingleChildScrollView agar seluruh layar bisa di-scroll
      body: SingleChildScrollView(
        child: Column(
          children: [
            // BAGIAN 1: HEADER HIJAU
            _buildHeader(),

            // BAGIAN 2: KONTEN UTAMA DENGAN BACKGROUND PUTIH
            _buildMainContent(),
          ],
        ),
      ),
      // BAGIAN 6: BOTTOM NAVIGATION BAR (dibuat statis)
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // WIDGET UNTUK HEADER HIJAU
  Widget _buildHeader() {
    return Container(
      color: const Color(0xFF0EA781),
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 40),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage("https://placehold.co/40x40"),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo,',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'LS Sans',
                  ),
                ),
                Text(
                  'Ahmad Sahroni 👋🏻',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'LS Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.40),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_outlined,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  // WIDGET UNTUK SEMUA KONTEN DI BAWAH HEADER
  Widget _buildMainContent() {
    return Transform.translate(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BAGIAN 3: BANNER CAROUSEL
            _buildBannerCarousel(),
            const SizedBox(height: 24),

            // BAGIAN 4: PROGRAM DARI LUARSEKOLAH
            const Text(
              'Program dari Luarsekolah',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'LS Sans',
              ),
            ),
            const SizedBox(height: 16),
            _buildProgramsSection(),
            const SizedBox(height: 24),

            // BAGIAN 5: REDEEM VOUCHER PRAKERJA
            _buildVoucherCard(),
            const SizedBox(height: 24),
            
            // BAGIAN 6: KELAS TERPOPULER
            const Text(
              'Kelas Terpopuler di Prakerja',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'LS Sans',
              ),
            ),
            const SizedBox(height: 16),
            _buildPopularClassSection(),

          ],
        ),
      ),
    );
  }

  // WIDGET UNTUK BANNER CAROUSEL/SLIDER
  Widget _buildBannerCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: PageView.builder(
            controller: _bannerController,
            itemCount: _bannerCount,
            onPageChanged: (index) {
              setState(() {
                _currentBannerPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: const DecorationImage(
                    image: NetworkImage("https://placehold.co/320x150"),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        // Indikator dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_bannerCount, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: _currentBannerPage == index ? 24 : 8,
              decoration: BoxDecoration(
                color: _currentBannerPage == index
                    ? const Color(0xFF0EA781)
                    : const Color(0xFFE5E5E9),
                borderRadius: BorderRadius.circular(12),
              ),
            );
          }),
        ),
      ],
    );
  }
  
  // WIDGET UNTUK 4 ICON PROGRAM
  Widget _buildProgramsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildProgramIcon(icon: Icons.work_outline, label: 'Prakerja'),
        _buildProgramIcon(icon: Icons.add_circle_outline, label: 'magang+'),
        _buildProgramIcon(icon: Icons.subscriptions_outlined, label: 'Subs'),
        _buildProgramIcon(icon: Icons.grid_view_outlined, label: 'Lainnya'),
      ],
    );
  }

  // Helper untuk membuat satu icon program
  Widget _buildProgramIcon({required IconData icon, required String label}) {
    return Column(
      children: [
        Container(
          width: 68,
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FB),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF0EA781), size: 28),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  // WIDGET UNTUK KARTU VOUCHER
  Widget _buildVoucherCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFCACECF)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Redeem Voucher Prakerjamu',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Kamu pengguna Prakerja? Segera redeem vouchermu sekarang juga',
            style: TextStyle(
              color: Color(0xFF6B6E6F),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: 'Masukkan Voucher Prakerja',
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Color(0xFFCACECF)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Color(0xFFCACECF)),
              ),
            ),
          )
        ],
      ),
    );
  }

  // WIDGET UNTUK LIST KELAS TERPOPULER (HORIZONTAL)
  Widget _buildPopularClassSection() {
    return SizedBox(
      height: 290, // Beri tinggi tetap untuk list horizontal
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5, // Misal ada 5 kelas
        itemBuilder: (context, index) {
          return _buildClassCard();
        },
      ),
    );
  }

  // WIDGET REUSABLE UNTUK KARTU KELAS
  Widget _buildClassCard() {
    return Container(
      width: 236, // Lebar kartu
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 7,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar Kelas
          Container(
            height: 120,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
              image: DecorationImage(
                image: NetworkImage("https://placehold.co/236x120"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Deskripsi Kelas
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tags
                Row(
                  children: [
                    _buildTag('Prakerja', const Color(0xFF2693F8)),
                    const SizedBox(width: 8),
                    _buildTag('SPL', const Color(0xFF25C07E)),
                  ],
                ),
                const SizedBox(height: 8),
                // Judul Kelas
                const Text(
                  'Teknik Pemilahan dan Pengolahan Sampah',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                // Rating
                const Row(
                  children: [
                    Text(
                      '4.5',
                      style: TextStyle(color: Color(0xFFD1881A), fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.star, color: Color(0xFFD1881A), size: 16),
                    Icon(Icons.star, color: Color(0xFFD1881A), size: 16),
                    Icon(Icons.star, color: Color(0xFFD1881A), size: 16),
                    Icon(Icons.star, color: Color(0xFFD1881A), size: 16),
                    Icon(Icons.star_half, color: Color(0xFFD1881A), size: 16),
                  ],
                ),
                const SizedBox(height: 8),
                // Harga
                const Text(
                  'Rp 1.500.000',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper untuk membuat tag kelas
  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }

  // WIDGET UNTUK BOTTOM NAVIGATION BAR
  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // Agar semua item terlihat
      currentIndex: 0, // Item 'Beranda' aktif
      selectedItemColor: const Color(0xFF0EA781),
      unselectedItemColor: const Color(0xFF6C6F70),
      selectedFontSize: 12,
      unselectedFontSize: 12,
      onTap: (index) {
        // Logika pindah halaman bisa ditambahkan di sini
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school_outlined),
          label: 'Kelas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.video_library_outlined),
          label: 'Kelasku',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.monetization_on_outlined),
          label: 'koinLS',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Akun',
        ),
      ],
    );
  }
}