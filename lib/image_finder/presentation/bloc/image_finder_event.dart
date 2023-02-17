part of 'image_finder_bloc.dart';

@immutable
abstract class ImageFinderEvent extends Equatable {
  const ImageFinderEvent();
}

class GetImageEvent extends ImageFinderEvent {
  const GetImageEvent();

  @override
  List<Object?> get props => [];
}

class SaveLocalImageEvent extends ImageFinderEvent {
  const SaveLocalImageEvent(this.image);

  final CoffeeImage image;

  @override
  List<Object?> get props => [image];
}
