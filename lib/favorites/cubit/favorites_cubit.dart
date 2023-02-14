import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:very_good_coffee_app/app/injectable/injectable.dart';
import 'package:very_good_coffee_app/domain/entities/coffee_image.dart';
import 'package:very_good_coffee_app/domain/usecases/get_local_images.dart';
import 'package:very_good_coffee_app/domain/usecases/save_local_image.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({
    GetLocalImages? getLocalImages,
    SaveLocalImage? saveLocalImage,
  })  : _getLocalImages = getLocalImages ?? injectable.get<GetLocalImages>(),
        _saveLocalImage = saveLocalImage ?? injectable.get<SaveLocalImage>(),
        super(const FavoritesState());

  final GetLocalImages _getLocalImages;
  final SaveLocalImage _saveLocalImage;

  Future<void> getLocalImages() async {
    emit(const FavoritesStateLoading());

    final result = await _getLocalImages.call();

    result.fold((failure) {
      emit(const FavoritesStateError(error: 'failure'));
    }, (images) {
      emit(FavoritesStateLoaded(images: images));
    });
  }

  Future<void> saveLocalImage({required CoffeeImage image}) async {
    await _saveLocalImage(image: image);
  }
}
