import 'package:bloc_test/bloc_test.dart';
import 'package:very_good_coffee_app/image_finder/image_finder.dart';

class MockImageFinderBloc extends MockBloc<ImageFinderEvent, ImageFinderState>
    implements ImageFinderBloc {}
