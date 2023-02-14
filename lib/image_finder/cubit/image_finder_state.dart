part of 'image_finder_cubit.dart';

class ImageFinderState extends Equatable {
  const ImageFinderState();

  @override
  List get props => [];
}

class ImageFinderStateError extends ImageFinderState {
  const ImageFinderStateError({required this.error});

  final String error;

  @override
  List get props => [error];
}

class ImageFinderStateLoaded extends ImageFinderState {
  const ImageFinderStateLoaded({required this.image});

  final String image;

  @override
  List get props => [image];
}
