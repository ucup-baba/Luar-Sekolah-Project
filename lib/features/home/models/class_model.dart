// Cetakan (Blueprint) untuk sebuah data kelas.
class ClassModel {
  final String id;
  final String imagePath;
  final List<String> tags;
  final String title;
  final double rating;
  final int price;

  ClassModel({
    required this.id,
    required this.imagePath,
    required this.tags,
    required this.title,
    required this.rating,
    required this.price,
  });

  // ✅ TAMBAHKAN FACTORY CONSTRUCTOR INI
  factory ClassModel.fromJson(Map<String, dynamic> json) {
    // Helper untuk mengubah List<dynamic> menjadi List<String>
    // Ini penting karena JSON biasanya tidak tahu tipe data list secara spesifik.
    List<String> parseTags(dynamic tagsJson) {
      if (tagsJson is List) {
        // Ubah setiap item di list menjadi String
        return tagsJson.map((tag) => tag.toString()).toList();
      }
      return []; // Kembalikan list kosong jika formatnya bukan List
    }

    return ClassModel(
      // Ambil 'id' dari JSON. Jika tidak ada, beri nilai default string kosong.
      id: json['id'] as String? ?? '',

      // Ambil 'imagePath'. GANTI 'imagePath' dengan nama key yang benar dari API Anda (misal: 'image_url', 'thumbnail')
      imagePath: json['imagePath'] as String? ?? 'https://placehold.co/236x120?text=Kelas',

      // Gunakan helper parseTags untuk mengambil data 'tags'.
      tags: parseTags(json['tags']),

      // Ambil 'title'.
      title: json['title'] as String? ?? 'Tanpa Judul',

      // Ambil 'rating'. 'num' bisa menerima int atau double dari JSON.
      // Kita ubah ke double dan beri default 0.0 jika tidak ada.
      rating: (json['rating'] as num? ?? 0.0).toDouble(),

      // Ambil 'price'. Kita ubah ke int dan beri default 0 jika tidak ada.
      price: (json['price'] as num? ?? 0).toInt(),
    );
  }
}