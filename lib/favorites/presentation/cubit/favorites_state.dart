part of 'favorites_cubit.dart';

class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List get props => [];
}

class FavoritesStateError extends FavoritesState {
  const FavoritesStateError({required this.error});

  final String error;

  @override
  List get props => [error];
}

class FavoritesStateLoading extends FavoritesState {
  const FavoritesStateLoading();

  @override
  List get props => [];
}

class FavoritesStateLoaded extends FavoritesState {
  const FavoritesStateLoaded({required this.images});

  final List<CoffeeImage> images;

  @override
  List get props => [images];
}
