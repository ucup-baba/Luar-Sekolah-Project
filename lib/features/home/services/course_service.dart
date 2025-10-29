import 'package:flutter/material.dart';
import '../models/class_model.dart'; // Model untuk data admin (harga, dll)
import '../models/my_course_model.dart'; // Model untuk data user (progress, dll)

class CourseService with ChangeNotifier {
  // === DATABASE PALSU ===
  
  // 1. Daftar SEMUA kelas yang tersedia di platform (untuk layar Admin)
  final List<ClassModel> _allCourses = [
    ClassModel(
      id: 'c1',
      title: 'Teknik Pemilahan dan Pengolahan Sampah',
      imagePath: 'https://img.freepik.com/free-photo/arrangement-gardening-tools_23-2148882627.jpg?size=626&ext=jpg',
      tags: ['Prakerja', 'SPL'],
      rating: 4.5,
      price: 1500000,
    ),
    ClassModel(
      id: 'c2',
      title: 'Membangun Usaha Bengkel dari Nol',
      imagePath: 'https://img.freepik.com/free-photo/mechanic-changing-tires-car-service_1303-26938.jpg?size=626&ext=jpg',
      tags: ['Prakerja'],
      rating: 4.8,
      price: 1250000,
    ),
  ];

  // 2. Daftar kelas yang DIMILIKI pengguna (untuk layar "Kelasku")
  final List<MyCourseModel> _myCourses = [
    MyCourseModel(
      id: 'c2', // ID harus sama dengan ClassModel
      imageUrl: 'https://img.freepik.com/free-photo/mechanic-changing-tires-car-service_1303-26938.jpg?size=626&ext=jpg',
      title: 'Membangun Usaha Bengkel dari Nol',
      provider: 'Luarsekolah',
      progress: 75,
    )
  ];

  // === GETTERS (Agar UI bisa mengambil data) ===

  List<ClassModel> get allCourses => _allCourses;
  List<MyCourseModel> get myCourses => _myCourses;

  // === LOGIKA BISNIS (CRUD) ===

  /// Dipanggil dari layar Admin saat "Tambah Kelas"
  void createCourse(ClassModel newCourse) {
    // 1. Tambahkan ke daftar admin
    _allCourses.add(newCourse);

    // 2. LANGSUNG TAMBAHKAN KE "KELASKU" DENGAN PROGRESS 0%
    // (Ini adalah logika yang Anda minta)
    final newEnrolledCourse = MyCourseModel(
      id: newCourse.id,
      imageUrl: newCourse.imagePath,
      title: newCourse.title,
      provider: 'Luarsekolah', // Asumsi
      progress: 0, // Progress awal 0%
    );
    _myCourses.add(newEnrolledCourse);

    // 3. Beri tahu semua layar yang mendengarkan!
    notifyListeners();
  }

  /// Dipanggil dari layar Admin saat "Delete"
  void deleteCourse(String courseId) {
    // 1. Hapus dari daftar admin
    _allCourses.removeWhere((course) => course.id == courseId);
    
    // 2. Hapus juga dari "Kelasku"
    _myCourses.removeWhere((course) => course.id == courseId);

    // 3. Beri tahu semua layar yang mendengarkan!
    notifyListeners();
  }

  /// Dipanggil dari layar Admin saat "Edit"
  void updateCourse(ClassModel updatedCourse) {
    // 1. Cari dan update di daftar admin
    final index = _allCourses.indexWhere((course) => course.id == updatedCourse.id);
    if (index != -1) {
      _allCourses[index] = updatedCourse;
    }

    // 2. Cari dan update juga di "Kelasku"
    final myCourseIndex = _myCourses.indexWhere((course) => course.id == updatedCourse.id);
    if (myCourseIndex != -1) {
      // Ambil progress lama agar tidak hilang
      final oldProgress = _myCourses[myCourseIndex].progress;
      _myCourses[myCourseIndex] = MyCourseModel(
        id: updatedCourse.id,
        imageUrl: updatedCourse.imagePath,
        title: updatedCourse.title,
        provider: 'Luarsekolah',
        progress: oldProgress, // Pertahankan progress lama
      );
    }
    
    // 3. Beri tahu semua layar yang mendengarkan!
    notifyListeners();
  }
}
final courseService = CourseService();