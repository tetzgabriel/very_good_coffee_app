part of 'home_cubit.dart';

enum HomeTab { finder, favorites }

class HomeState extends Equatable {
  const HomeState({
    this.tab = HomeTab.finder,
  });

  final HomeTab tab;

  @override
  List<Object> get props => [tab];
}