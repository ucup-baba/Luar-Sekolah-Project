import 'package:flutter/material.dart';
// TODO: Update the import path below if your class_model.dart is in a different folder.
// TODO: Update the import path below to the correct location of class_model.dart if needed.
import '../models/class_model.dart';

class ClassCard extends StatelessWidget {
  final ClassModel course;

  const ClassCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
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
                image: AssetImage(course.imagePath),
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
                  children: course.tags
                      .map((tag) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: _buildTag(
                                tag,
                                tag == 'Prakerja'
                                    ? const Color(0xFF2693F8)
                                    : const Color(0xFF25C07E)),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 8),
                Text(
                  course.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      course.rating.toString(),
                      style: const TextStyle(
                          color: Color(0xFFD1881A), fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 4),
                    ...List.generate(5, (index) => Icon(
                      index < course.rating.floor() ? Icons.star : 
                      index < course.rating ? Icons.star_half : Icons.star_border,
                      color: const Color(0xFFD1881A), size: 16)
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  course.price,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
}
