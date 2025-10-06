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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildMainContent(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // BAGIAN 1: HEADER HIJAU DENGAN PROFIL
  Widget _buildHeader() {
    return Container(
      color: const Color(0xFF0EA781),
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 40),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            // Ganti 'profile_picture.png' dengan nama file Anda
            backgroundImage: AssetImage("assets/images/profile_picture.png"),
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

  // BAGIAN 2: SEMUA KONTEN DI BAWAH HEADER
  Widget _buildMainContent() {
    return Transform.translate(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBannerCarousel(),
            const SizedBox(height: 24),
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
            _buildVoucherCard(),
            const SizedBox(height: 24),
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

  // WIDGET UNTUK BANNER CAROUSEL
  Widget _buildBannerCarousel() {
    // Ganti nama file banner sesuai dengan file Anda
    final List<String> bannerImages = [
      'assets/images/banner1.png',
      'assets/images/banner2.png',
      'assets/images/banner3.png',
    ];

    return Column(
      children: [
        SizedBox(
          height: 150,
          child: PageView.builder(
            controller: _bannerController,
            itemCount: bannerImages.length,
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
                  image: DecorationImage(
                    image: AssetImage(bannerImages[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(bannerImages.length, (index) {
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
        // Ganti nama file ikon sesuai dengan file Anda
        _buildProgramIcon(imagePath: 'assets/icon/prakerja_icon.png', label: 'Prakerja'),
        _buildProgramIcon(imagePath: 'assets/icon/magang_icon.png', label: 'magang+'),
        _buildProgramIcon(imagePath: 'assets/icon/subs_icon.jpg', label: 'Subs'),
        _buildProgramIcon(imagePath: 'assets/icon/lainnya_icon.png', label: 'Lainnya'),
      ],
    );
  }

  // Helper untuk membuat satu icon program
  Widget _buildProgramIcon({required String imagePath, required String label}) {
    return Column(
      children: [
        Container(
          width: 68,
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FB),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Image.asset(
              imagePath,
              width: 32,
              height: 32,
            ),
          ),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ganti nama file ikon sesuai dengan file Anda
          Image.asset(
            'assets/icon/prakerja_icon.png',
            width: 26,
            height: 40,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Redeem Voucher Prakerjamu',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Kamu pengguna Prakerja? Segera redeem vouchermu sekarang juga',
                  style: TextStyle(color: Color(0xFF6B6E6F), fontSize: 14),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan Voucher Prakerja',
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
          ),
        ],
      ),
    );
  }

  // WIDGET UNTUK LIST KELAS TERPOPULER
  Widget _buildPopularClassSection() {
    // Ganti nama file gambar kelas sesuai dengan file Anda
    final List<String> classImages = [
      'assets/images/kelas_sampah.jpg',
      'assets/images/kelas_tanaman.png',
      'assets/images/kelas_swiftui.png',
      'assets/images/kelas_dart.png',
      'assets/images/kelas_css.png',
    ];

    return SizedBox(
      height: 290,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: classImages.length,
        itemBuilder: (context, index) {
          return _buildClassCard(imagePath: classImages[index]);
        },
      ),
    );
  }

  // WIDGET REUSABLE UNTUK KARTU KELAS
  Widget _buildClassCard({required String imagePath}) {
    return Container(
      width: 236,
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
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _buildTag('Prakerja', const Color(0xFF2693F8)),
                    const SizedBox(width: 8),
                    _buildTag('SPL', const Color(0xFF25C07E)),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Teknik Pemilahan dan Pengolahan Sampah',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Text(
                      '4.5',
                      style: TextStyle(
                          color: Color(0xFFD1881A), fontWeight: FontWeight.w500),
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
                const Text(
                  'Rp 1.500.000',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  // WIDGET UNTUK BOTTOM NAVIGATION BAR
  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 0,
      selectedItemColor: const Color(0xFF0EA781),
      unselectedItemColor: const Color(0xFF6C6F70),
      selectedFontSize: 12,
      unselectedFontSize: 12,
      onTap: (index) {},
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