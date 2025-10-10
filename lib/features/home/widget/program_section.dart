import 'package:flutter/material.dart';

class ProgramSection extends StatelessWidget {
  const ProgramSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildProgramIcon(
            imagePath: 'assets/icon/prakerja_icon.png', label: 'Prakerja'),
        _buildProgramIcon(
            imagePath: 'assets/icon/magang_icon.png', label: 'magang+'),
        _buildProgramIcon(
            imagePath: 'assets/icon/luarsekolah_icon.png', label: 'Subs'),
        _buildProgramIcon(
            imagePath: 'assets/icon/lainnya_icon.png', label: 'Lainnya'),
      ],
    );
  }

  // Helper untuk membuat satu icon program
  Widget _buildProgramIcon({required String imagePath, required String label}) {
    return Column(
      children: [
        Container(
          width: 68,
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FB),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Image.asset(
              imagePath,
              width: 32,
              height: 32,
              // Menambahkan error builder untuk aset lokal
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.image_not_supported, size: 32, color: Colors.grey);
              },
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
