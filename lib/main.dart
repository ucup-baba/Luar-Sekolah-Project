import 'package:flutter/material.dart'; 
import 'features/auth/screens/register_screen.dart'; 
import 'features/auth/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() {
  // ✅ PERBAIKAN 2: "Bungkus" aplikasi Anda dengan provider DI SINI
  runApp(
    ChangeNotifierProvider(
      create: (context) => authService, // Sediakan AuthService ke seluruh aplikasi
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget { 
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterScreen(),
    );
  }
} 