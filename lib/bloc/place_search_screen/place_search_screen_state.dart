part of 'place_search_screen_bloc.dart';

abstract class PlaceSearchScreenState extends Equatable {
  const PlaceSearchScreenState();

  @override
  List<Object> get props => [];
}

class PlaceSearchLoadingState extends PlaceSearchScreenState {}

class PlaceSearchLoadResultState extends PlaceSearchScreenState {
  final List<Place> places;

  PlaceSearchLoadResultState({required this.places});

  @override
  List<Object> get props => [places];
}

class PlaceSearcLoadResultEmptyState extends PlaceSearchScreenState {}

class PlaceSearchLoadHistoryState extends PlaceSearchScreenState {
  final List<String> queries;

  PlaceSearchLoadHistoryState({required this.queries});

  @override
  List<Object> get props => [queries];
}

class PlaceSearchErrorState extends PlaceSearchScreenState {}