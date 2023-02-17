import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee_app/core/injectable/injectable.dart';
import 'package:very_good_coffee_app/favorites/favorites.dart';
import 'package:very_good_coffee_app/image_finder/image_finder.dart';
import 'package:very_good_coffee_app/image_finder/presentation/bloc/image_finder_bloc.dart';
import 'package:very_good_coffee_app/l10n/l10n.dart';

class ImageFinderPage extends StatelessWidget {
  const ImageFinderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          injectable.get<ImageFinderBloc>()..add(const GetImageEvent()),
      child: const ImageFinderView(),
    );
  }
}

class ImageFinderView extends StatelessWidget {
  const ImageFinderView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    const mediumTextStyle = TextStyle(
      fontWeight: FontWeight.w500,
    );
    final primaryButtonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.all(const Color(0xFF2A48DE)),
    );
    final secondaryButtonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.all(const Color(0xFFFF4F9D)),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.appBarTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                l10n.imageFinderTitle,
                style: mediumTextStyle,
              ),
              Text(
                l10n.imageFinderSubtitle,
                style: mediumTextStyle,
              ),
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
                    onPressed: () => context
                        .read<ImageFinderBloc>()
                        .add(const GetImageEvent()),
                    icon: const Icon(Icons.refresh),
                    label: Text(l10n.refreshButtonLabel),
                    style: primaryButtonStyle,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (context.read<ImageFinderBloc>().state
                          is ImageFinderStateLoaded) {
                        return context.read<ImageFinderBloc>().add(
                              SaveLocalImageEvent(
                                (context.read<ImageFinderBloc>().state
                                        as ImageFinderStateLoaded)
                                    .image,
                              ),
                            );
                      }

                      return;
                    },
                    icon: const Icon(Icons.favorite),
                    label: Text(l10n.favoritesButtonLabel),
                    style: primaryButtonStyle,
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
                style: secondaryButtonStyle,
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
      child: context.select((ImageFinderBloc bloc) {
        if (bloc.state is ImageFinderStateLoaded) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              (bloc.state as ImageFinderStateLoaded).image.file,
              fit: BoxFit.fitHeight,
            ),
          );
        }

        if (bloc.state is ImageFinderStateError) {
          return Center(child: Text(l10n.errorText));
        }

        return const CircularProgressIndicator();
      }),
    );
  }
}
