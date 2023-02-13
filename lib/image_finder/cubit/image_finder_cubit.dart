import 'package:bloc/bloc.dart';

class ImageFinderCubit extends Cubit<int> {
  ImageFinderCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}
