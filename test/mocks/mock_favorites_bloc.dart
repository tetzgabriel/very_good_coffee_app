import 'package:bloc_test/bloc_test.dart';
import 'package:very_good_coffee_app/favorites/favorites.dart';

class MockFavoritesBloc extends MockBloc<FavoritesEvent, FavoritesState>
    implements FavoritesBloc {}
