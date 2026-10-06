import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/image_data.dart';
import '../../../helpers/extensions.dart';
import '../../../helpers/favorites_provider.dart';
import '../../../main.dart';
import '../../reusables/network_photo.dart';
import 'imagescreenvm.dart';

class ImageDetailScreenView extends StatelessWidget {
  const ImageDetailScreenView({super.key, required this.image});

  final ImageData image;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ImageScreenVM>(
      create: (_) => getIt<ImageScreenVM>(),
      child: _ImageDetailBody(image: image),
    );
  }
}

class _ImageDetailBody extends StatelessWidget {
  const _ImageDetailBody({required this.image});

  final ImageData image;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ImageScreenVM>();
    final favorites = context.watch<FavoritesProvider>();
    final isFavorite = favorites.isFavorite(image.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo details'),
        actions: [
          IconButton(
            tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
            onPressed: () => favorites.toggle(image),
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.redAccent : null,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'photo-${image.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: NetworkPhoto(
                    url: image.largeImageUrl.isNotEmpty
                        ? image.largeImageUrl
                        : image.webFormatUrl,
                    fit: BoxFit.cover,
                    memCacheWidth: 1400,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Description', style: context.theme.textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(image.description, style: context.theme.textTheme.bodyLarge),
            const SizedBox(height: 20),
            _PhotographerRow(image: image),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _StatChip(icon: Icons.favorite, label: image.likes.asShortCount),
                _StatChip(
                  icon: Icons.visibility_outlined,
                  label: image.views.asShortCount,
                ),
                _StatChip(
                  icon: Icons.download_outlined,
                  label: image.downloads.asShortCount,
                ),
                _StatChip(
                  icon: Icons.chat_bubble_outline,
                  label: image.comments.asShortCount,
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (vm.downloading) ...[
              LinearProgressIndicator(value: vm.progress),
              const SizedBox(height: 8),
              Text(
                'Downloading ${(vm.progress * 100).round()}%',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
            ],
            FilledButton.icon(
              onPressed: vm.downloading ? null : () => _download(context, vm),
              icon: const Icon(Icons.download),
              label: Text(vm.downloading ? 'Downloading...' : 'Download'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _download(BuildContext context, ImageScreenVM vm) async {
    final path = await vm.download(image);
    if (!context.mounted) return;

    if (path == null) {
      if (vm.errorMessage.isNotEmpty) {
        context.showSnack(vm.errorMessage);
      }
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: const Text('Image downloaded'),
          action: SnackBarAction(
            label: 'OPEN FILE',
            onPressed: () => _openFile(context, vm, path),
          ),
        ),
      );
  }

  Future<void> _openFile(
    BuildContext context,
    ImageScreenVM vm,
    String path,
  ) async {
    if (!context.mounted) return;

    final opened = await vm.openFile(path);
    if (opened || !context.mounted) return;

    context.showSnack('Could not open the file.');
  }
}

class _PhotographerRow extends StatelessWidget {
  const _PhotographerRow({required this.image});

  final ImageData image;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: SizedBox(
            width: 40,
            height: 40,
            child: NetworkPhoto(url: image.userImageUrl, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                image.user.isEmpty ? 'Unknown' : image.user,
                style: context.theme.textTheme.titleSmall,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '${image.imageWidth} x ${image.imageHeight}',
                style: context.theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: context.colorScheme.outline),
          const SizedBox(width: 6),
          Text(label, style: context.theme.textTheme.labelMedium),
        ],
      ),
    );
  }
}
