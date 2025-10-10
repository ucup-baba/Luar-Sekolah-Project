// Jangan lupa import User model dan Flutter material
import 'package:flutter/material.dart';
import '../../auth/services/auth_service.dart'; // Sesuaikan path ke auth_service.dart

class HomeHeader extends StatelessWidget {
  // PERBAIKAN 1: Menambahkan titik pada 'this.user'
  const HomeHeader({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0EA781),
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 40),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage("assets/images/profile_picture.png"),
            onBackgroundImageError: null,
          ),
          const SizedBox(width: 12),
          // PERBAIKAN 2: Menghapus 'const' dari Expanded karena child-nya tidak constant
          Expanded(
            // PERBAIKAN 2: Menghapus 'const' dari Column karena child-nya tidak constant
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text( // 'const' di sini tidak apa-apa karena teksnya statis
                  'Halo,',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'LS Sans',
                  ),
                ),
                Text( // 'const' di sini HARUS dihapus karena menggunakan variabel 'user.name'
                  '${user.name}! 😁',
                  style: const TextStyle( // const di TextStyle boleh karena isinya statis
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
}