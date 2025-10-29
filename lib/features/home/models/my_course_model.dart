class MyCourseModel {
  final String id; // ✅ 1. TAMBAHKAN FIELD 'id'
  final String imageUrl;
  final String title;
  final String provider;
  final int progress; // Progress dalam persen (0-100)

  MyCourseModel({
    required this.id, // ✅ 2. TAMBAHKAN 'id' KE KONSTRUKTOR
    required this.imageUrl,
    required this.title,
    required this.provider,
    required this.progress,
  });

  // Opsional: Tambahkan factory constructor .fromJson jika Anda pakai API nanti
  factory MyCourseModel.fromJson(Map<String, dynamic> json) {
    return MyCourseModel(
      id: json['id'] ?? '', // Sesuaikan nama key dari API
      imageUrl: json['image_url'] ?? '',
      title: json['title'] ?? 'Tanpa Judul',
      provider: json['provider'] ?? 'Luarsekolah',
      progress: (json['progress'] ?? 0).toInt(),
    );
  }
}
