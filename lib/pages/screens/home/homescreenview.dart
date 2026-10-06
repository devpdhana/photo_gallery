import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/app_constants.dart';
import '../../../helpers/extensions.dart';
import '../../../main.dart';
import '../../reusables/empty_view.dart';
import '../../reusables/error_view.dart';
import '../../reusables/image_grid_tile.dart';
import '../../reusables/loading_view.dart';
import '../favorites/favoritesscreenview.dart';
import '../image/imagescreenview.dart';
import 'homescreenmodel.dart';
import 'homescreenvm.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeScreenVM>(
      create: (_) => getIt<HomeScreenVM>()..loadFirstPage(),
      child: const _HomeScreenBody(),
    );
  }
}

class _HomeScreenBody extends StatefulWidget {
  const _HomeScreenBody();

  @override
  State<_HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<_HomeScreenBody> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 400) {
      context.read<HomeScreenVM>().loadMore();
    }
  }

  Future<void> _search(String value) async {
    final vm = context.read<HomeScreenVM>();
    await vm.search(value);

    if (!mounted) return;
    if (vm.status == ScreenStatus.loaded && vm.errorMessage.isNotEmpty) {
      context.showSnack(vm.errorMessage);
    }
  }

  Future<void> _refresh() async {
    final vm = context.read<HomeScreenVM>();
    await vm.refresh();

    if (!mounted) return;
    if (vm.status == ScreenStatus.loaded && vm.errorMessage.isNotEmpty) {
      context.showSnack(vm.errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeScreenVM>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
          IconButton(
            tooltip: 'Favorites',
            onPressed: () => context.push(const FavoritesScreenView()),
            icon: const Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              onChanged: (_) => setState(() {}),
              onSubmitted: _search,
              decoration: InputDecoration(
                hintText: 'Search photos...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                          _search('');
                        },
                      ),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(child: _buildContent(vm)),
        ],
      ),
    );
  }

  Widget _buildContent(HomeScreenVM vm) {
    switch (vm.status) {
      case ScreenStatus.loading:
        return const LoadingView();
      case ScreenStatus.error:
        return ErrorView(message: vm.errorMessage, onRetry: vm.retry);
      case ScreenStatus.loaded:
        if (vm.images.isEmpty) {
          return const EmptyView(
            icon: Icons.image_search_outlined,
            title: 'No photos found',
            subtitle: 'Try a different search term.',
          );
        }
        return RefreshIndicator(onRefresh: _refresh, child: _buildGrid(vm));
    }
  }

  Widget _buildGrid(HomeScreenVM vm) {
    final showFooter =
        vm.hasMore || vm.loadingMore || vm.loadMoreFailed;

    return GridView.builder(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 240,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: vm.images.length + (showFooter ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= vm.images.length) {
          return _buildFooter(vm);
        }

        final image = vm.images[index];
        return ImageGridTile(
          image: image,
          onTap: () => context.push(ImageDetailScreenView(image: image)),
        );
      },
    );
  }

  Widget _buildFooter(HomeScreenVM vm) {
    if (vm.loadMoreFailed) {
      return InkWell(
        onTap: vm.loadMore,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.refresh, size: 28),
            const SizedBox(height: 8),
            Text(
              'Couldn\'t load more',
              style: context.theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}
