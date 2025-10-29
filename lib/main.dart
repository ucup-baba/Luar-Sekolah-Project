import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import semua service Anda
import 'features/auth/services/auth_service.dart';
import 'features/home/services/course_service.dart'; // Import CourseService

// Import halaman awal Anda
import 'features/auth/screens/register_screen.dart'; // Ganti jika perlu

void main() {
  runApp(
    // Gunakan MultiProvider
    MultiProvider(
      providers: [
        // Daftarkan AuthService
        ChangeNotifierProvider(create: (context) => authService),
        // Daftarkan CourseService
        ChangeNotifierProvider(create: (context) => courseService),
      ],
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
      home: RegisterScreen(), // Halaman awal
    );
  }
}