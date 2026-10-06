import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/image_data.dart';
import '../../helpers/favorites_provider.dart';
import 'network_photo.dart';

class ImageGridTile extends StatelessWidget {
  const ImageGridTile({super.key, required this.image, this.onTap});

  final ImageData image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>();
    final isFavorite = favorites.isFavorite(image.id);

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: 'photo-${image.id}',
              child: NetworkPhoto(
                url: image.webFormatUrl,
                fit: BoxFit.cover,
                memCacheWidth: 500,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () => favorites.toggle(image),
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: 20,
                  color: isFavorite ? Colors.redAccent : Colors.white,
                  shadows: const [Shadow(color: Colors.black54, blurRadius: 6)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
