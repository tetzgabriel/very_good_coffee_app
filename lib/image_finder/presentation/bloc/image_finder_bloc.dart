import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:very_good_coffee_app/core/injectable/injectable.dart';
import 'package:very_good_coffee_app/image_finder/domain/entities/coffee_image.dart';
import 'package:very_good_coffee_app/image_finder/domain/usecases/get_image.dart';
import 'package:very_good_coffee_app/image_finder/domain/usecases/save_local_image.dart';

part 'image_finder_event.dart';
part 'image_finder_state.dart';

class ImageFinderBloc extends Bloc<ImageFinderEvent, ImageFinderState> {
  ImageFinderBloc({
    GetImage? getImage,
    SaveLocalImage? saveLocalImage,
  })  : _getImage = getImage ?? injectable.get<GetImage>(),
        _saveLocalImage = saveLocalImage ?? injectable.get<SaveLocalImage>(),
        super(ImageFinderInitial()) {
    on<ImageFinderEvent>((event, emit) async {
      if (event is GetImageEvent) {
        emit(const ImageFinderStateLoading());
        final result = await _getImage.call();

        result.fold((failure) {
          emit(const ImageFinderStateError(error: 'failure'));
        }, (image) {
          emit(ImageFinderStateLoaded(image: image));
        });
      }
      if (event is SaveLocalImageEvent) {
        await _saveLocalImage(image: event.image);
      }
    });
  }

  final GetImage _getImage;
  final SaveLocalImage _saveLocalImage;
}
