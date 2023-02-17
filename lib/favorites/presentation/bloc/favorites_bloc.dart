import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:very_good_coffee_app/app/injectable/injectable.dart';
import 'package:very_good_coffee_app/favorites/domain/usecases/get_local_images.dart';

import 'package:very_good_coffee_app/image_finder/domain/entities/coffee_image.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({GetLocalImages? getLocalImages})
      : _getLocalImages = getLocalImages ?? injectable.get<GetLocalImages>(),
        super(const FavoritesInitial()) {
    on<FavoritesEvent>((event, emit) async {
      if (event is GetLocalImagesEvent) {
        emit(const FavoritesStateLoading());

        final result = await _getLocalImages.call();

        result.fold((failure) {
          emit(const FavoritesStateError(error: 'failure'));
        }, (images) {
          emit(FavoritesStateLoaded(images: images));
        });
      }
    });
  }

  final GetLocalImages _getLocalImages;
}
