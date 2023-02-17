import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/app/app.dart';
import 'package:very_good_coffee_app/image_finder/image_finder.dart';

import '../../helpers/helpers.dart';
import '../../injectable/injectable.dart';
import '../../mocks/coffee_image_fixture.dart';

void main() {
  setupTestServices();

  final mockImageFinderBloc = injectable.get<ImageFinderBloc>();

  setUp(() {
    final imageFinderState = ImageFinderStateLoaded(
      image: CoffeeImageFixture.model,
    );

    whenListen(
      mockImageFinderBloc,
      Stream.fromIterable([imageFinderState]),
    );

    when(() => mockImageFinderBloc.state).thenReturn(imageFinderState);

    when(() => mockImageFinderBloc.add(const GetImageEvent()))
        .thenAnswer((_) async {});
  });

  group('App', () {
    testWidgets('renders ImageFinderPage', (tester) async {
      await mockNetworkImage(() async => tester.pumpApp(const App()));

      await tester.pumpApp(const App());
      expect(find.byType(ImageFinderPage), findsOneWidget);
    });
  });
}
