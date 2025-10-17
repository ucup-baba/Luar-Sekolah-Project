import 'package:flutter/material.dart';
import '../models/my_course_model.dart'; // Sesuaikan path jika perlu

class MyCourseCard extends StatelessWidget {
  final MyCourseModel course;

  const MyCourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar di sebelah kiri
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              course.imageUrl,
              width: 100,
              height: 92,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 100,
                height: 92,
                color: Colors.grey[200],
                child: const Icon(Icons.broken_image, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Konten di sebelah kanan
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Judul Kelas
                Text(
                  course.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),

                // Nama Provider dengan Ikon Centang
                Row(
                  children: [
                    Text(
                      course.provider,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.check_circle, color: Color(0xFF25C07E), size: 16),
                  ],
                ),
                const SizedBox(height: 12),

                // Progress Bar
                Column(
                  children: [
                    LinearProgressIndicator(
                      value: course.progress / 100, // Nilai dari 0.0 sampai 1.0
                      backgroundColor: Colors.grey[300],
                      color: const Color(0xFF25C07E),
                      minHeight: 6,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Progress Belajar', style: TextStyle(color: Colors.grey, fontSize: 12)),
                        Text('${course.progress}%', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
