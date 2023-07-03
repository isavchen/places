import 'package:places/domain/place.dart';

abstract class SearchPlaceState {}

class SearchPlaceInitialState extends SearchPlaceState {}

class SearchPlaceLoadingState extends SearchPlaceState {}

class SearchPlaceDataState extends SearchPlaceState {
  final List<Place> places;

  SearchPlaceDataState({required this.places});
}

class SearchPlaceHistoryState extends SearchPlaceState {
  final List<String> queries;

  SearchPlaceHistoryState({required this.queries});
}

class SearchPlaceErrorState extends SearchPlaceState {}
