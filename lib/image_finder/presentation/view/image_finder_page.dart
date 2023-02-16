import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee_app/app/injectable/injectable.dart';
import 'package:very_good_coffee_app/favorites/favorites.dart';
import 'package:very_good_coffee_app/image_finder/image_finder.dart';
import 'package:very_good_coffee_app/l10n/l10n.dart';

class ImageFinderPage extends StatelessWidget {
  const ImageFinderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injectable.get<ImageFinderCubit>()..getImage(),
      child: const ImageFinderView(),
    );
  }
}

class ImageFinderView extends StatelessWidget {
  const ImageFinderView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.appBarTitle)),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(l10n.imageFinderTitle),
              Text(l10n.imageFinderSubtitle),
              const SizedBox(
                height: 24,
              ),
              const ImageSection(),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () =>
                        context.read<ImageFinderCubit>().getImage(),
                    icon: const Icon(Icons.refresh),
                    label: Text(l10n.refreshButtonLabel),
                  ),
                  ElevatedButton.icon(
                    onPressed: () =>
                        context.read<ImageFinderCubit>().saveLocalImage(
                              image: (context.read<ImageFinderCubit>().state
                                      as ImageFinderStateLoaded)
                                  .image,
                            ),
                    icon: const Icon(Icons.favorite),
                    label: Text(l10n.favoritesButtonLabel),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (context) => const FavoritesPage(),
                  ),
                ),
                child: Text(l10n.navigateToFavoritesButtonLabel),
              )
            ],
          ),
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
    final l10n = context.l10n;

    return SizedBox(
      height: 250,
      width: 250,
      child: context.select((ImageFinderCubit cubit) {
        if (cubit.state is ImageFinderStateLoaded) {
          return Image.network(
            (cubit.state as ImageFinderStateLoaded).image.file,
            fit: BoxFit.fitHeight,
          );
        }

        if (cubit.state is ImageFinderStateError) {
          return Center(child: Text(l10n.errorText));
        }

        return const CircularProgressIndicator();
      }),
    );
  }
}
