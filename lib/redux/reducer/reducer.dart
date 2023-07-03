import 'package:places/redux/action/place_search_action.dart';
import 'package:places/redux/reducer/search_place_reducer.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:redux/redux.dart';

final reducer = combineReducers<AppState>([
  TypedReducer<AppState, FindPlaceAction>(findPlaceReducer),
  TypedReducer<AppState, ShowSearchResultAction>(resultSearchPlaceReducer),
  TypedReducer<AppState, ShowSearchHistoryAction>(showHistorySearchPlaceReducer),
  TypedReducer<AppState, ShowSearchErrorAction>(errorSearchPlaceReducer),
]);
