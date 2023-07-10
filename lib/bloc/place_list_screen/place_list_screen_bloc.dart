import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/domain/place.dart';

part 'place_list_screen_event.dart';
part 'place_list_screen_state.dart';

class PlaceListScreenBloc
    extends Bloc<PlaceListScreenEvent, PlaceListScreenState> {
  final PlaceInteractor placeInteractor;

  PlaceListScreenBloc({required this.placeInteractor})
      : super(PlaceListScreenLoadingState()) {
    on<LoadPlacesList>(_loadPlaces);
  }

  Future<void> _loadPlaces(
      LoadPlacesList event, Emitter<PlaceListScreenState> emit) async {
    emit(PlaceListScreenLoadingState());
    try {
      final places = await placeInteractor.getAllPlaces();
      emit(PlaceListScreenSuccessState(places: places));
    } catch (e) {
      emit(PlaceListScreenErrorState());
    }
  }
}
