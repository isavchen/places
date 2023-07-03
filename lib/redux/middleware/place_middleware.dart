import 'package:dio/dio.dart';
import 'package:places/data/place_model_selector.dart';
import 'package:places/data/repository/placeRepository.dart';
import 'package:places/redux/action/place_search_action.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaceMiddleware implements MiddlewareClass<AppState> {
  final PlaceRepository _placeRepository;

  PlaceMiddleware(this._placeRepository);

  @override
  call(Store<AppState> store, action, NextDispatcher next) {
    if (action is FindPlaceAction) {
      if (action.request.isEmpty) {
        store.dispatch(LoadSearchHistoryAction());
      } else {
        _searchPlaces(store, action);
      }
    }

    if (action is LoadSearchHistoryAction) {
      _loadHistory(store);
    }

    if (action is RemoveQueryFromHistoryAction) {
      _removeFromSearchHistory(store, action);
    }

    if (action is ClearSearchHistoryAction) {
      _clearSearchHistory(store);
    }

    next(action);
  }

  Future<void> _searchPlaces(
      Store<AppState> store, FindPlaceAction action) async {
    try {
      final responseDto =
          await _placeRepository.getFilteredPlaces(namePlace: action.request);
      final resultData =
          responseDto.map((e) => placeModelFromDtoSelector(e)).toList();

      addToSearchHistory(action.request);

      store.dispatch(ShowSearchResultAction(places: resultData));
    } on DioError catch (_) {
      store.dispatch(ShowSearchErrorAction());
    }
  }

  Future<void> _loadHistory(Store<AppState> store) async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('history');

    store.dispatch(ShowSearchHistoryAction(queries: history ?? []));
  }

  Future<void> addToSearchHistory(String request) async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('history') ?? [];

    if (history.contains(request)) {
      history.remove(request);
      history.add(request);
    } else {
      history.add(request);
    }

    await prefs.setStringList('history', history);
  }

  Future<void> _removeFromSearchHistory(
      Store<AppState> store, RemoveQueryFromHistoryAction action) async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('history') ?? [];
    history.remove(action.query);

    await prefs.setStringList('history', history);

    store.dispatch(ShowSearchHistoryAction(queries: history));
  }

  Future<void> _clearSearchHistory(Store<AppState> store) async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('history') ?? [];
    history.clear();

    await prefs.setStringList('history', history);

    store.dispatch(ShowSearchHistoryAction(queries: history));
  }
}
