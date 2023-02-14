import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee_app/image_finder/image_finder.dart';
import 'package:very_good_coffee_app/l10n/l10n.dart';

class ImageFinderPage extends StatelessWidget {
  const ImageFinderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ImageFinderCubit(),
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
      appBar: AppBar(title: Text(l10n.counterAppBarTitle)),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            const ImageSection(),
            const SizedBox(
              height: 80,
            ),
            ElevatedButton.icon(
              onPressed: () => context.read<ImageFinderCubit>().getImage(),
              icon: const Icon(Icons.refresh),
              label: const Text('Reload'),
            ),
            ElevatedButton.icon(
              onPressed: () => context.read<ImageFinderCubit>().saveLocalImage(
                    image: (context.read<ImageFinderCubit>().state
                            as ImageFinderStateLoaded)
                        .image,
                  ),
              icon: const Icon(Icons.favorite),
              label: const Text('Favorite'),
            )
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
      child: context.select((ImageFinderCubit cubit) {
        if (cubit.state is ImageFinderStateLoaded) {
          return Image.network(
            (cubit.state as ImageFinderStateLoaded).image.file,
          );
        } else if (cubit.state is ImageFinderStateError) {
          return const Text('Error');
        } else {
          return const CircularProgressIndicator();
        }
      }),
    );
  }
}
