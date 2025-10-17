import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Sesuaikan path ke service dan model Anda
import '../../auth/services/auth_service.dart';

class HomeHeader extends StatelessWidget {
  // ✅ KEMBALIKAN KE KONSTRUKTOR SEDERHANA
  // Widget ini tidak perlu menerima data user lagi.
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ GUNAKAN CONSUMER UNTUK "MENDENGARKAN" AUTHSERVICE
    return Consumer<AuthService>(
      builder: (context, auth, child) {
        // Ambil data user yang sedang login dari provider
        final User? currentUser = auth.loggedInUser;

        // Jaga-jaga jika user belum login, tampilkan fallback
        if (currentUser == null) {
          return Container(
            height: 140, // Sesuaikan tinggi
            color: const Color(0xFF0EA781),
            alignment: Alignment.center,
            child: const Text('User tidak ditemukan', style: TextStyle(color: Colors.white)),
          );
        }
        
        // Jika user ada, bangun UI dengan data terbaru
        return Container(
          color: const Color(0xFF0EA781),
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 40),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                // ✅ Gunakan data foto dari 'currentUser'
                // Beri nilai default jika photoPath null
                backgroundImage: AssetImage(
                    currentUser.photoPath ?? "assets/images/profile_picture.png"
                ),
                onBackgroundImageError: (exception, stackTrace) {},
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Halo,', style: TextStyle(color: Colors.white)),
                    // ✅ Gunakan data nama dari 'currentUser'
                    Text(
                      '${currentUser.name}! 👋🏻',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              // ... sisa widget notifikasi ...
            ],
          ),
        );
      },
    );
  }
}