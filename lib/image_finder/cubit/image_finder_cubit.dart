import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:very_good_coffee_app/app/injectable/injectable.dart';
import 'package:very_good_coffee_app/domain/entities/coffee_image.dart';
import 'package:very_good_coffee_app/domain/usecases/get_image.dart';
import 'package:very_good_coffee_app/domain/usecases/save_local_image.dart';

part 'image_finder_state.dart';

class ImageFinderCubit extends Cubit<ImageFinderState> {
  ImageFinderCubit({
    GetImage? getImage,
    SaveLocalImage? saveLocalImage,
  })  : _getImage = getImage ?? injectable.get<GetImage>(),
        _saveLocalImage = saveLocalImage ?? injectable.get<SaveLocalImage>(),
        super(const ImageFinderState());

  final GetImage _getImage;
  final SaveLocalImage _saveLocalImage;

  Future<void> getImage() async {
    emit(const ImageFinderStateLoading());

    final result = await _getImage.call();

    result.fold((failure) {
      emit(const ImageFinderStateError(error: 'failure'));
    }, (image) {
      emit(ImageFinderStateLoaded(image: image));
    });
  }

  Future<void> saveLocalImage({required CoffeeImage image}) async {
    await _saveLocalImage(image: image);
  }
}
