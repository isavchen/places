import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/domain/place.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'place_search_screen_event.dart';
part 'place_search_screen_state.dart';

class PlaceSearchScreenBloc
    extends Bloc<PlaceSearchScreenEvent, PlaceSearchScreenState> {
  final SearchInteractor _searchInteractor;
  PlaceSearchScreenBloc(this._searchInteractor)
      : super(PlaceSearchLoadingState()) {
    on<FindPlaceByRequestEvent>(_searchPlace);
    on<LoadSearchHistoryEvent>(_loadHistory);
    on<RemoveQueryFromHistoryEvent>(_removeFromSearchHistory);
    on<ClearSearchHistory>(_clearSearchHistory);
  }

  Future<void> _searchPlace(FindPlaceByRequestEvent event,
      Emitter<PlaceSearchScreenState> emit) async {
    emit(PlaceSearchLoadingState());
    if (event.request.isEmpty) {
      _loadHistory(LoadSearchHistoryEvent(), emit);
    } else {
      try {
        _addToSearchHistory(event.request);
        final result =
            await _searchInteractor.searchPlaces(namePlace: event.request);
        if (result.isEmpty)
          emit(PlaceSearcLoadResultEmptyState());
        else
          emit(PlaceSearchLoadResultState(places: result));
      } catch (e) {
        emit(PlaceSearchErrorState());
      }
    }
  }

  Future<void> _loadHistory(LoadSearchHistoryEvent event,
      Emitter<PlaceSearchScreenState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('search_history');

    emit(PlaceSearchLoadHistoryState(queries: history ?? []));
  }

  Future<void> _addToSearchHistory(String request) async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('search_history') ?? [];

    if (history.contains(request)) {
      history.remove(request);
      history.add(request);
    } else {
      history.add(request);
    }

    await prefs.setStringList('search_history', history);
  }

  Future<void> _removeFromSearchHistory(RemoveQueryFromHistoryEvent event,
      Emitter<PlaceSearchScreenState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('search_history') ?? [];
    history.remove(event.query);

    await prefs.setStringList('search_history', history);

    emit(PlaceSearchLoadHistoryState(queries: history));
  }

  Future<void> _clearSearchHistory(
      ClearSearchHistory event, Emitter<PlaceSearchScreenState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('search_history') ?? [];
    history.clear();

    await prefs.setStringList('search_history', history);

    emit(PlaceSearchLoadHistoryState(queries: history));
  }
}
