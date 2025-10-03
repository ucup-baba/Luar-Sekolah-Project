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
            backgroundImage: NetworkImage("data:image/jpeg;base64,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"),
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
                  'Yusuf Syaifulloh 👋🏻',
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