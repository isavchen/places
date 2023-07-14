import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/bloc/visiting_screen/want_to_visit/want_to_visit_event.dart';
import 'package:places/bloc/visiting_screen/want_to_visit/want_to_visit_state.dart';

class WantToVisitBloc extends Bloc<WantToVisitEvent, WantToVisitState> {
  WantToVisitBloc() : super(WantToVisitListUpdatedSuccess(places: [])) {
    on<WantToVisitUpdateList>(_updatePlacesList);
  }

  void _updatePlacesList(
      WantToVisitUpdateList event, Emitter<WantToVisitState> emit) {
    final state = this.state;
    if (state is WantToVisitListUpdatedSuccess) {
      final ifListContainsPlace =
          state.places.any((place) => place.id == event.place.id);

      if (ifListContainsPlace) {
        emit(WantToVisitListUpdatedSuccess(
            places: List.from(state.places)
              ..removeWhere((place) => place.id == event.place.id)));
      } else {
        emit(WantToVisitListUpdatedSuccess(
            places: List.from(state.places)..add(event.place)));
      }
    }
  }
}
