import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'sign_in_screen.dart'; // <-- 1. TAMBAHKAN IMPORT INI

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Menggunakan Lottie.network untuk mengambil animasi dari URL
              Lottie.network(
                'https://lottie.host/8345bf3b-fa21-4410-bdcb-4e9cc489a32a/V1rjPsocFO.json',
                height: 150,
              ),
              const SizedBox(height: 32),

              // Judul Utama
              const Text(
                'Email Verifikasi Sudah Dikirim ke Emailmu',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF09090B),
                ),
              ),
              const SizedBox(height: 16),

              // Teks Deskripsi dengan Link di Dalamnya
              Text.rich(
                TextSpan(
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                    height: 1.5,
                  ),
                  children: [
                    const TextSpan(
                      text:
                          'Silakan cek kotak masuk di email mail@mail.xo untuk melakukan verifikasi akunmu. Jika kamu tidak menerima pesan di kotak masukmu, coba untuk cek di folder spam atau ',
                    ),
                    TextSpan(
                      text: 'kirim ulang verifikasi',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // TODO: Tambahkan logika kirim ulang email
                          print('Kirim ulang verifikasi diklik!');
                        },
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Link "Akses halaman masuk" dengan Ikon
              InkWell(
                onTap: () {
                  // 2. UBAH BAGIAN INI UNTUK NAVIGASI
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Akses halaman masuk',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.open_in_new,
                      color: Colors.blue,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}