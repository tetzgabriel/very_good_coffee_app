import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/favorites/favorites.dart';

import '../../../helpers/helpers.dart';
import '../../../injectable/injectable.dart';
import '../../../mocks/coffee_image_fixture.dart';

void main() {
  setupTestServices();

  final mockFavoritesBloc = injectable.get<FavoritesBloc>();

  setUp(() {
    final favoritesStateLoaded = FavoritesStateLoaded(
      images: CoffeeImageFixture.list,
    );

    whenListen(
      mockFavoritesBloc,
      Stream.fromIterable([favoritesStateLoaded]),
    );

    when(() => mockFavoritesBloc.state).thenReturn(favoritesStateLoaded);

    when(() => mockFavoritesBloc.add(const GetLocalImagesEvent()))
        .thenAnswer((_) async {});
  });

  testWidgets('Should render Favorites Page with a grid view',
      (WidgetTester tester) async {
    await tester.pumpApp(const FavoritesPage());
    await tester.pump();

    expect(find.byType(FavoritesPage), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
  });

  testWidgets('Should render Circular Progress Indicator if state is Loading',
      (WidgetTester tester) async {
    const favoritesStateLoading = FavoritesStateLoading();

    whenListen(
      mockFavoritesBloc,
      Stream.fromIterable([favoritesStateLoading]),
    );

    when(() => mockFavoritesBloc.state).thenReturn(favoritesStateLoading);

    await tester.pumpApp(const FavoritesPage());
    await tester.pump();

    expect(find.byType(FavoritesPage), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should render Error text if state is Error',
      (WidgetTester tester) async {
    const favoritesStateLoading = FavoritesStateLoading();

    whenListen(
      mockFavoritesBloc,
      Stream.fromIterable([favoritesStateLoading]),
    );

    when(() => mockFavoritesBloc.state).thenReturn(favoritesStateLoading);

    await tester.pumpApp(const FavoritesPage());
    await tester.pump();

    expect(find.byType(FavoritesPage), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);
  });
}
