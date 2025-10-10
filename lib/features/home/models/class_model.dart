// Cetakan (Blueprint) untuk sebuah data kelas.
class ClassModel {
  final String imagePath;
  final List<String> tags;
  final String title;
  final double rating;
  final String price;

  ClassModel({
    required this.imagePath,
    required this.tags,
    required this.title,
    required this.rating,
    required this.price,
  });
}
