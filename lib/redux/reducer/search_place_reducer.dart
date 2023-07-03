import 'package:places/redux/action/place_search_action.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:places/redux/state/place_search_state.dart';

AppState findPlaceReducer(AppState state, FindPlaceAction action) {
  return state.cloneWith(searchPlaceState: SearchPlaceLoadingState());
}

AppState resultSearchPlaceReducer(
    AppState state, ShowSearchResultAction action) {
  return state.cloneWith(
      searchPlaceState: SearchPlaceDataState(places: action.places));
}

AppState showHistorySearchPlaceReducer(
    AppState state, ShowSearchHistoryAction action) {
  return state.cloneWith(
      searchPlaceState: SearchPlaceHistoryState(queries: action.queries));
}

AppState errorSearchPlaceReducer(AppState state, ShowSearchErrorAction action) {
  return state.cloneWith(searchPlaceState: SearchPlaceErrorState());
}
