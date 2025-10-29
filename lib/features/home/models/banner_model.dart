class BannerModel {
  final String imageUrl;
  final String linkUrl; // URL tujuan saat banner di-klik (jika ada)

  BannerModel({
    required this.imageUrl,
    required this.linkUrl,
  });

  // Factory constructor untuk membuat BannerModel dari data JSON
  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      // Ambil 'image_url' dari JSON, beri nilai default jika tidak ada
      imageUrl: json['image_url'] as String? ?? 'https://placehold.co/600x150?text=Banner',
      // Ambil 'link_url' dari JSON, beri nilai default '#' jika tidak ada
      linkUrl: json['link_url'] as String? ?? '#',
    );
  }
}
