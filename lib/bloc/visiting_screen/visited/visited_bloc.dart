import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/bloc/visiting_screen/visited/visited_event.dart';
import 'package:places/bloc/visiting_screen/visited/visited_state.dart';

class VisitedBloc extends Bloc<VisitedEvent, VisitedState> {
  VisitedBloc() : super(VisitedListUpdatedSuccess(places: [])) {
    on<VisitedUpdateList>(_updatePlacesList);
  }

  void _updatePlacesList(VisitedUpdateList event, Emitter<VisitedState> emit) {
    final state = this.state;
    if (state is VisitedListUpdatedSuccess) {
      final ifListContainsPlace =
          state.places.any((place) => place.id == event.place.id);

      if (ifListContainsPlace) {
        emit(VisitedListUpdatedSuccess(
            places: List.from(state.places)
              ..removeWhere((place) => place.id == event.place.id)));
      } else {
        emit(VisitedListUpdatedSuccess(
            places: List.from(state.places)..add(event.place)));
      }
    }
  }
}
