import 'package:places/redux/state/place_search_state.dart';

class AppState {
  final SearchPlaceState searchPlaceState;

  AppState({SearchPlaceState? searchPlaceState})
      : this.searchPlaceState = searchPlaceState ?? SearchPlaceInitialState();

  AppState cloneWith({
    SearchPlaceState? searchPlaceState,
  }) =>
      AppState(
        searchPlaceState: searchPlaceState ?? this.searchPlaceState,
      );
}
