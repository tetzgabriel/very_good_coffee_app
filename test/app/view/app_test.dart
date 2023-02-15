import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee_app/app/app.dart';
import 'package:very_good_coffee_app/image_finder/image_finder.dart';

import '../../injectable/injectable.dart';

void main() {
  setupTestServices();

  group('App', () {
    testWidgets('renders ImageFinderPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(ImageFinderPage), findsOneWidget);
    });
  });
}
