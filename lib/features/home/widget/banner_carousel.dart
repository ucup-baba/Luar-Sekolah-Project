import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int _currentBannerPage = 0;
  final List<String> _bannerImages = [
    'https://res.cloudinary.com/dpiow0bkp/image/upload/v1759934338/Banner_Mobile_qxocpq.png',
    'https://res.cloudinary.com/dpiow0bkp/image/upload/v1759967402/imgkarir1-1_kmgypj.svg',
    'https://res.cloudinary.com/dpiow0bkp/image/upload/v1759969270/imgkarir1-2_epyu2c.svg',
    'https://res.cloudinary.com/dpiow0bkp/image/upload/v1759972292/Autololos_dytskr.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150.0,
          child: PageView.builder(
            itemCount: _bannerImages.length,
            onPageChanged: (int page) {
              setState(() {
                _currentBannerPage = page;
              });
            },
            itemBuilder: (context, index) {
              final String imageUrl = _bannerImages[index];
              Widget imageWidget;
              if (imageUrl.toLowerCase().endsWith('.svg')) {
                imageWidget = SvgPicture.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  placeholderBuilder: (context) =>
                      const Center(child: CircularProgressIndicator()),
                );
              } else {
                imageWidget = Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    return progress == null
                        ? child
                        : const Center(child: CircularProgressIndicator());
                  },
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: imageWidget,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_bannerImages.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              height: 8.0,
              width: _currentBannerPage == index ? 24.0 : 8.0,
              decoration: BoxDecoration(
                color: _currentBannerPage == index
                    ? Colors.blueAccent
                    : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(12),
              ),
            );
          }),
        ),
      ],
    );
  }
}
