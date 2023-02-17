import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/favorites/favorites.dart';
import 'package:very_good_coffee_app/image_finder/image_finder.dart';

import '../../../helpers/helpers.dart';
import '../../../injectable/injectable.dart';
import '../../../mocks/coffee_image_fixture.dart';

void main() {
  setupTestServices();

  final mockImageFinderBloc = injectable.get<ImageFinderBloc>();

  setUp(() {
    final imageFinderStateLoaded = ImageFinderStateLoaded(
      image: CoffeeImageFixture.model,
    );

    whenListen(
      mockImageFinderBloc,
      Stream.fromIterable([imageFinderStateLoaded]),
    );

    when(() => mockImageFinderBloc.state).thenReturn(imageFinderStateLoaded);

    when(() => mockImageFinderBloc.add(const GetImageEvent()))
        .thenAnswer((_) async {});
    when(
      () => mockImageFinderBloc.add(
        SaveLocalImageEvent(CoffeeImageFixture.model),
      ),
    ).thenAnswer((_) async {});
  });

  testWidgets('Should render Image Finder page', (WidgetTester tester) async {
    await mockNetworkImage(() async => tester.pumpApp(const ImageFinderPage()));

    await tester.pump();

    expect(find.byType(ImageFinderPage), findsOneWidget);
  });

  testWidgets('Should render Circular Progress Indicator if state is Loading',
      (WidgetTester tester) async {
    const imageFinderStateLoading = ImageFinderStateLoading();

    whenListen(
      mockImageFinderBloc,
      Stream.fromIterable([imageFinderStateLoading]),
    );

    when(() => mockImageFinderBloc.state).thenReturn(imageFinderStateLoading);

    await mockNetworkImage(() async => tester.pumpApp(const ImageFinderPage()));
    await tester.pump();

    expect(find.byType(ImageFinderPage), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should render Error text if state is Error',
      (WidgetTester tester) async {
    const imageFinderStateError = ImageFinderStateError(error: 'failure');

    whenListen(
      mockImageFinderBloc,
      Stream.fromIterable([imageFinderStateError]),
    );

    when(() => mockImageFinderBloc.state).thenReturn(imageFinderStateError);

    await mockNetworkImage(() async => tester.pumpApp(const ImageFinderPage()));
    await tester.pump();

    expect(find.byType(ImageFinderPage), findsOneWidget);
    expect(find.byType(Image), findsNothing);
    expect(find.byType(Text), findsNWidgets(7));
  });

  testWidgets(
    'New image button should load new image',
    (tester) async {
      final mockImageFinderBloc = injectable.get<ImageFinderBloc>();

      final imageFinderStateLoaded = ImageFinderStateLoaded(
        image: CoffeeImageFixture.model,
      );

      whenListen(
        mockImageFinderBloc,
        Stream.fromIterable([imageFinderStateLoaded]),
      );

      when(() => mockImageFinderBloc.state).thenReturn(imageFinderStateLoaded);

      when(() => mockImageFinderBloc.add(const GetImageEvent()))
          .thenAnswer((_) async {});

      await mockNetworkImage(
        () async => tester.pumpApp(
          const ImageFinderPage(),
        ),
      );

      await tester.tap(find.byIcon(Icons.refresh));

      verify(() => mockImageFinderBloc..add(const GetImageEvent()));
    },
  );

  testWidgets(
    'Add to favorites button should save image',
    (tester) async {
      await mockNetworkImage(
        () async => tester.pumpApp(
          const ImageFinderPage(),
        ),
      );

      await tester.tap(find.byIcon(Icons.favorite));

      verify(
        () => mockImageFinderBloc
          ..add(
            SaveLocalImageEvent(
              CoffeeImageFixture.model,
            ),
          ),
      ).called(1);
    },
  );

  testWidgets(
    'Go to favorites button should navigate',
    (tester) async {
      final mockFavoritesBloc = injectable.get<FavoritesBloc>();

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

      await mockNetworkImage(
        () async => tester.pumpApp(
          const ImageFinderPage(),
        ),
      );

      await tester.tap(find.text('Go to favorites'));
      await tester.pumpAndSettle();

      expect(find.byType(FavoritesPage), findsOneWidget);
    },
  );
}
