part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();
}

class GetLocalImagesEvent extends FavoritesEvent {
  const GetLocalImagesEvent();

  @override
  List<Object?> get props => [];
}
