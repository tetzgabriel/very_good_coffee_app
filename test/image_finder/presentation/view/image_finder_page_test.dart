import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/image_finder/image_finder.dart';

import '../../../helpers/helpers.dart';
import '../../../injectable/injectable.dart';
import '../../../mocks/coffee_image_fixture.dart';

void main() {
  setupTestServices();

  final mockImageFinderCubit = injectable.get<ImageFinderCubit>();

  setUp(() {
    final imageFinderStateLoaded = ImageFinderStateLoaded(
      image: CoffeeImageFixture.model,
    );

    whenListen(
      mockImageFinderCubit,
      Stream.fromIterable([imageFinderStateLoaded]),
    );

    when(() => mockImageFinderCubit.state).thenReturn(imageFinderStateLoaded);

    when(mockImageFinderCubit.getImage).thenAnswer((_) async {});
    when(
      () => mockImageFinderCubit.saveLocalImage(
        image: CoffeeImageFixture.model,
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
      mockImageFinderCubit,
      Stream.fromIterable([imageFinderStateLoading]),
    );

    when(() => mockImageFinderCubit.state).thenReturn(imageFinderStateLoading);

    await mockNetworkImage(() async => tester.pumpApp(const ImageFinderPage()));
    await tester.pump();

    expect(find.byType(ImageFinderPage), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should render Error text if state is Error',
      (WidgetTester tester) async {
    const imageFinderStateError = ImageFinderStateError(error: 'failure');

    whenListen(
      mockImageFinderCubit,
      Stream.fromIterable([imageFinderStateError]),
    );

    when(() => mockImageFinderCubit.state).thenReturn(imageFinderStateError);

    await mockNetworkImage(() async => tester.pumpApp(const ImageFinderPage()));
    await tester.pump();

    expect(find.byType(ImageFinderPage), findsOneWidget);
    expect(find.byType(Image), findsNothing);
    expect(find.byType(Text), findsNWidgets(7));
  });

  testWidgets(
    'New image button should load new image',
    (tester) async {
      final mockImageFinderCubit = injectable.get<ImageFinderCubit>();

      final imageFinderStateLoaded = ImageFinderStateLoaded(
        image: CoffeeImageFixture.model,
      );

      whenListen(
        mockImageFinderCubit,
        Stream.fromIterable([imageFinderStateLoaded]),
      );

      when(() => mockImageFinderCubit.state).thenReturn(imageFinderStateLoaded);

      when(mockImageFinderCubit.getImage).thenAnswer((_) async {});

      await mockNetworkImage(
        () async => tester.pumpApp(
          const ImageFinderPage(),
        ),
      );

      await tester.tap(find.byIcon(Icons.refresh));

      //getImage is called on build, so we need to verify for a second call
      verify(mockImageFinderCubit.getImage);
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
        () => mockImageFinderCubit.saveLocalImage(
          image: CoffeeImageFixture.model,
        ),
      ).called(1);
    },
  );
}
