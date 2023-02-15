import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee_app/app/app.dart';
import 'package:very_good_coffee_app/image_finder/image_finder.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(ImageFinderPage), findsOneWidget);
    });
  });
}
