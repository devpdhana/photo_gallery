import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkPhoto extends StatelessWidget {
  const NetworkPhoto({
    super.key,
    required this.url,
    this.fit,
    this.memCacheWidth,
  });

  final String url;
  final BoxFit? fit;
  final int? memCacheWidth;

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return const ColoredBox(
        color: Color(0xFFECEFF3),
        child: Center(child: Icon(Icons.image_outlined, color: Colors.grey)),
      );
    }

    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      memCacheWidth: memCacheWidth,
      fadeInDuration: const Duration(milliseconds: 250),
      placeholder: (context, url) => const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      errorWidget: (context, url, error) => const ColoredBox(
        color: Color(0xFFECEFF3),
        child: Center(
          child: Icon(Icons.broken_image_outlined, color: Colors.grey),
        ),
      ),
    );
  }
}
