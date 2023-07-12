import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:places/bloc/place_list_screen/place_list_screen_bloc.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/place.dart';

part 'filter_button_event.dart';
part 'filter_button_state.dart';

class FilterButtonBloc extends Bloc<FilterButtonEvent, FilterButtonState> {
  final PlaceInteractor _placeInteractor;
  final PlaceListScreenBloc _placeListScreenBloc;
  FilterButtonBloc(this._placeInteractor, this._placeListScreenBloc)
      : super(FilterButtonLoadingState()) {
    on<LoadFiltratedPlaces>(_loadFiltratedPlace);
    on<ApplyFilter>(_applyFilter);
  }

  Future<void> _loadFiltratedPlace(
      LoadFiltratedPlaces event, Emitter<FilterButtonState> emit) async {
    emit(FilterButtonLoadingState());
    final places =
        await _placeInteractor.filtrationPlaces(filter: event.filter);

    emit(FilterButtonLoadedState(places: places));
  }

  void _applyFilter(ApplyFilter event, Emitter<FilterButtonState> emit) {
    final state = this.state;
    if (state is FilterButtonLoadedState) {
      _placeListScreenBloc.add(AddFilteredPlaces(places: state.places));
    }
  }
}
