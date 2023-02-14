import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:very_good_coffee_app/app/injectable/injectable.dart';
import 'package:very_good_coffee_app/domain/usecases/get_image.dart';

part 'image_finder_state.dart';

class ImageFinderCubit extends Cubit<ImageFinderState> {
  ImageFinderCubit({
    GetImage? getImage,
  }) : _getImage = getImage ?? injectable.get<GetImage>(),
      super(const ImageFinderState());

  final GetImage _getImage;

  Future<void> getImage() async {
    final result = await _getImage.call();
  
    result.fold(
        (failure) {
          emit(const ImageFinderStateError(error: 'failure'));
        },
        (image) {
          emit(ImageFinderStateLoaded(image: image.file));
        }
    );
  }
}
