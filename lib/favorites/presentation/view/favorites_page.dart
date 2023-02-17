import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee_app/core/injectable/injectable.dart';
import 'package:very_good_coffee_app/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:very_good_coffee_app/l10n/l10n.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injectable.get<FavoritesBloc>()
        ..add(
          const GetLocalImagesEvent(),
        ),
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
      body: context.select((FavoritesBloc bloc) {
        if (bloc.state is FavoritesStateLoaded) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: (bloc.state as FavoritesStateLoaded).images.length,
              itemBuilder: (BuildContext context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl:
                        (bloc.state as FavoritesStateLoaded).images[index].file,
                    fit: BoxFit.fitHeight,
                  ),
                );
              },
            ),
          );
        }

        if (bloc.state is FavoritesStateError) {
          return Text(l10n.errorText);
        }

        return const CircularProgressIndicator();
      }),
    );
  }
}
