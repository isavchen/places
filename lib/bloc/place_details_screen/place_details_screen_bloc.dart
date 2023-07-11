import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/domain/place.dart';

part 'place_details_screen_event.dart';
part 'place_details_screen_state.dart';

class PlaceDetailsScreenBloc
    extends Bloc<PlaceDetailsScreenEvent, PlaceDetailsScreenState> {
  final PlaceInteractor _placeInteractor;
  PlaceDetailsScreenBloc(this._placeInteractor)
      : super(PlaceDetailsScreenLoadingState()) {
    on<LoadPlaceDetails>(_loadPlaceDetails);
  }

  Future<void> _loadPlaceDetails(
      LoadPlaceDetails event, Emitter<PlaceDetailsScreenState> emit) async {
    emit(PlaceDetailsScreenLoadingState());
    try {
      final place = await _placeInteractor.getPlaceDetails(id: event.id);
      emit(PlaceDetailsScreenSuccessState(place: place));
    } catch (e) {
      emit(PlaceDetailsScreenErrorState());
    }
  }
}
