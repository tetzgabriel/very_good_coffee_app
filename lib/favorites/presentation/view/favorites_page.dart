import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee_app/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:very_good_coffee_app/l10n/l10n.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoritesCubit()..getLocalImages(),
      child: const FavoritesView(),
    );
  }
}

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.appBarTitle)),
      body: Center(
        child: Column(
          children: const [
            SizedBox(
              height: 80,
            ),
            ImageSection(),
          ],
        ),
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: context.select((FavoritesCubit cubit) {
        if (cubit.state is FavoritesStateLoaded) {
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: (cubit.state as FavoritesStateLoaded).images.length,
            itemBuilder: (BuildContext context, int index) {
              return CachedNetworkImage(
                imageUrl:
                    (cubit.state as FavoritesStateLoaded).images[index].file,
              );
            },
          );
        } else if (cubit.state is FavoritesStateError) {
          return const Text('Error');
        } else {
          return const CircularProgressIndicator();
        }
      }),
    );
  }
}
