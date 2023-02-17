part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesState extends Equatable {
  const FavoritesState();
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial();

  @override
  List<Object?> get props => [];
}

class FavoritesStateError extends FavoritesState {
  const FavoritesStateError({required this.error});

  final String error;

  @override
  List<dynamic> get props => [error];
}

class FavoritesStateLoading extends FavoritesState {
  const FavoritesStateLoading();

  @override
  List<dynamic> get props => [];
}

class FavoritesStateLoaded extends FavoritesState {
  const FavoritesStateLoaded({required this.images});

  final List<CoffeeImage> images;

  @override
  List<dynamic> get props => [images];
}
