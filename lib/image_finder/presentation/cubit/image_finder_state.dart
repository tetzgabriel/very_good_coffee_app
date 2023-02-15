part of 'image_finder_cubit.dart';

class ImageFinderState extends Equatable {
  const ImageFinderState();

  @override
  List<dynamic> get props => [];
}

class ImageFinderStateError extends ImageFinderState {
  const ImageFinderStateError({required this.error});

  final String error;

  @override
  List<dynamic> get props => [error];
}

class ImageFinderStateLoading extends ImageFinderState {
  const ImageFinderStateLoading();

  @override
  List<dynamic> get props => [];
}

class ImageFinderStateLoaded extends ImageFinderState {
  const ImageFinderStateLoaded({required this.image});

  final CoffeeImage image;

  @override
  List<dynamic> get props => [image];
}
