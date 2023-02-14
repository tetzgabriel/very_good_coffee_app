import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee_app/domain/entities/coffee_image.dart';
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
            context.select((ImageFinderCubit cubit) {
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
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => context.read<ImageFinderCubit>().getImage(),
            child: const Icon(Icons.add),
          ),
          context.select((ImageFinderCubit cubit) {
            if (cubit.state is ImageFinderStateLoaded) {
              return FloatingActionButton(
                onPressed: () => context
                    .read<ImageFinderCubit>()
                    .saveLocalImage(
                        image: (cubit.state as ImageFinderStateLoaded).image),
                child: const Icon(Icons.abc_rounded),
              );
            } else {
              return Text('teste');
            }
          })
        ],
      ),
    );
  }
}
