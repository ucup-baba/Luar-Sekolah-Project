import 'package:flutter/material.dart';
import '../models/class_model.dart';
import 'class_card.dart';

class PopularClassSection extends StatelessWidget {
  const PopularClassSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy ini nantinya bisa Anda ganti dengan data dari API
    final List<ClassModel> popularCourses = [
      ClassModel(
          imagePath: 'assets/images/kelas_sampah.jpg',
          tags: ['Prakerja', 'SPL'],
          title: 'Teknik Pemilahan dan Pengolahan Sampah',
          rating: 4.5,
          price: 'Rp 1.500.000'),
      ClassModel(
          imagePath: 'assets/images/kelas_tanaman.png',
          tags: ['Prakerja'],
          title: 'Meningkatkan Pertumbuhan Tanaman untuk Petani',
          rating: 4.8,
          price: 'Rp 1.250.000'),
      ClassModel(
          imagePath: 'assets/images/kelas_swiftui.png',
          tags: ['Prakerja', 'iOS'],
          title: 'Belajar SwiftUI untuk Pemula dari Dasar',
          rating: 4.9,
          price: 'Rp 2.000.000'),
    ];

    return SizedBox(
      height: 290,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: popularCourses.length,
        itemBuilder: (context, index) {
          return ClassCard(course: popularCourses[index]);
        },
      ),
    );
  }
}

