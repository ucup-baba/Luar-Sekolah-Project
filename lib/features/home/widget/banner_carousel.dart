import 'package:flutter/material.dart';
// Import BannerModel (sesuaikan path jika perlu)
// ✅ PERBAIKAN: Pastikan import ini ada dan path-nya benar
import '../models/banner_model.dart';

// 1. Ubah kembali menjadi StatelessWidget (karena tidak perlu state untuk API)
class BannerCarousel extends StatefulWidget { // Ubah jadi StatefulWidget jika butuh state untuk _currentBannerPage
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> { // Tambahkan State
  // 2. Buat daftar data dummy secara manual
  final List<BannerModel> dummyBanners = [
    BannerModel(
      imageUrl: 'https://res.cloudinary.com/dpiow0bkp/image/upload/v1759934338/Banner_Mobile_qxocpq.png', // URL Gambar Asli 1
      linkUrl: '#', // Tautan dummy
    ),
    BannerModel(
      imageUrl: 'https://via.placeholder.com/600x150/0000FF/FFFFFF?text=Banner+2', // URL Gambar Placeholder 2
      linkUrl: '#',
    ),
    BannerModel(
      imageUrl: 'https://via.placeholder.com/600x150/FF0000/FFFFFF?text=Banner+3', // URL Gambar Placeholder 3
      linkUrl: '#',
    ),
  ];

  int _currentBannerPage = 0; // State untuk indikator

  @override
  Widget build(BuildContext context) {
    // 3. Gunakan daftar dummyBanners untuk membangun UI
    return Column(
      children: [
        SizedBox(
          height: 150.0, // Sesuaikan tinggi banner jika perlu
          child: PageView.builder(
            itemCount: dummyBanners.length, // Gunakan panjang list dummy
            onPageChanged: (int page) {
               setState(() { // Update state untuk indikator
                 _currentBannerPage = page;
               });
            },
            itemBuilder: (context, index) {
              final banner = dummyBanners[index]; // Ambil data dari list dummy
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    banner.imageUrl, // Gunakan imageUrl dari data dummy
                    fit: BoxFit.cover,
                    // Tambahkan loading & error builder agar lebih baik
                    loadingBuilder: (context, child, progress) {
                      return progress == null
                          ? child
                          : const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        // Indikator titik-titik (menggunakan _currentBannerPage)
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: List.generate(dummyBanners.length, (index) {
             return AnimatedContainer(
               duration: const Duration(milliseconds: 300),
               margin: const EdgeInsets.symmetric(horizontal: 4.0),
               height: 8.0,
               width: _currentBannerPage == index ? 24.0 : 8.0,
               decoration: BoxDecoration(
                 color: _currentBannerPage == index ? Colors.blueAccent : Colors.grey.shade400,
                 borderRadius: BorderRadius.circular(12),
               ),
             );
           }),
         ),
      ],
    );
  }
}
