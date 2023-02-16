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
      body: context.select((FavoritesCubit cubit) {
        if (cubit.state is FavoritesStateLoaded) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: (cubit.state as FavoritesStateLoaded).images.length,
              itemBuilder: (BuildContext context, index) {
                return CachedNetworkImage(
                  imageUrl:
                  (cubit.state as FavoritesStateLoaded).images[index].file,
                  fit: BoxFit.fitHeight,
                );
              },
            ),
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
