import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/extensions.dart';
import '../../../main.dart';
import '../../reusables/empty_view.dart';
import '../../reusables/image_grid_tile.dart';
import '../image/imagescreenview.dart';
import 'favoritesscreenvm.dart';

class FavoritesScreenView extends StatelessWidget {
  const FavoritesScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoritesScreenVM>(
      create: (_) => getIt<FavoritesScreenVM>(),
      child: const _FavoritesBody(),
    );
  }
}

class _FavoritesBody extends StatelessWidget {
  const _FavoritesBody();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<FavoritesScreenVM>();
    final favorites = vm.favorites;
    final photos = favorites.favorites;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          photos.isEmpty ? 'Favorites' : 'Favorites (${favorites.count})',
        ),
      ),
      body: photos.isEmpty
          ? const EmptyView(
              icon: Icons.favorite_border,
              title: 'No favorites yet',
              subtitle: 'Tap the heart on any photo to keep it here.',
            )
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 240,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemCount: photos.length,
              itemBuilder: (context, index) {
                final image = photos[index];
                return ImageGridTile(
                  image: image,
                  onTap: () => context.push(ImageDetailScreenView(image: image)),
                );
              },
            ),
    );
  }
}
