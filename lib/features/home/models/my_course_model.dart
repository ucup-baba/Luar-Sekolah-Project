class MyCourseModel {
  final String imageUrl;
  final String title;
  final String provider;
  final int progress; // Progress dalam persen (0-100)

  MyCourseModel({
    required this.imageUrl,
    required this.title,
    required this.provider,
    required this.progress,
  });
}
