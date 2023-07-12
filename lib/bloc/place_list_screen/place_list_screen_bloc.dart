import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/domain/place.dart';

part 'place_list_screen_event.dart';
part 'place_list_screen_state.dart';

class PlaceListScreenBloc
    extends Bloc<PlaceListScreenEvent, PlaceListScreenState> {
  final PlaceInteractor _placeInteractor;

  PlaceListScreenBloc(this._placeInteractor)
      : super(PlaceListScreenLoadingState()) {
    on<LoadPlacesList>(_loadPlaces);
    on<AddFilteredPlaces>(_addFilteredPlaces);
  }

  Future<void> _loadPlaces(
      LoadPlacesList event, Emitter<PlaceListScreenState> emit) async {
    emit(PlaceListScreenLoadingState());
    try {
      final places = await _placeInteractor.getAllPlaces();
      emit(PlaceListScreenSuccessState(places: places));
    } catch (e) {
      emit(PlaceListScreenErrorState());
    }
  }

  void _addFilteredPlaces(
      AddFilteredPlaces event, Emitter<PlaceListScreenState> emit) {
    emit(PlaceListScreenSuccessState(places: event.places));
  }
}
