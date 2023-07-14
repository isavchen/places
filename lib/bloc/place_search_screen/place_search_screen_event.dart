part of 'place_search_screen_bloc.dart';

abstract class PlaceSearchScreenEvent extends Equatable {
  const PlaceSearchScreenEvent();

  @override
  List<Object> get props => [];
}

class FindPlaceByRequestEvent extends PlaceSearchScreenEvent {
  final String request;

  FindPlaceByRequestEvent({required this.request});

  @override
  List<Object> get props => [request];
}

class LoadSearchHistoryEvent extends PlaceSearchScreenEvent {}

class RemoveQueryFromHistoryEvent extends PlaceSearchScreenEvent {
  final String query;

  RemoveQueryFromHistoryEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class ClearSearchHistory extends PlaceSearchScreenEvent {}
