import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/favorites/favorites.dart';

import '../../../helpers/helpers.dart';
import '../../../injectable/injectable.dart';
import '../../../mocks/coffee_image_fixture.dart';

void main() {
  setupTestServices();

  final mockFavoritesCubit = injectable.get<FavoritesCubit>();

  setUp(() {
    final favoritesState = FavoritesStateLoaded(
      images: CoffeeImageFixture.list,
    );

    whenListen(
      mockFavoritesCubit,
      Stream.fromIterable([favoritesState]),
    );

    when(() => mockFavoritesCubit.state).thenReturn(favoritesState);
    when(mockFavoritesCubit.getLocalImages).thenAnswer((_) async {});
  });

  testWidgets('Should render a Favorites Page',
      (WidgetTester tester) async {
    await tester.pumpApp(const FavoritesPage());
    await tester.pump();

    expect(find.byType(FavoritesPage), findsOneWidget);
  });
}
