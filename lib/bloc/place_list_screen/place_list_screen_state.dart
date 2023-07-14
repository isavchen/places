part of 'place_list_screen_bloc.dart';

abstract class PlaceListScreenState extends Equatable {
  const PlaceListScreenState();

  @override
  List<Object> get props => [];
}

class PlaceListScreenLoadingState extends PlaceListScreenState {}

class PlaceListScreenSuccessState extends PlaceListScreenState {
  final List<Place> places;

  PlaceListScreenSuccessState({required this.places});

  @override
  List<Object> get props => [places];
}

class PlaceListScreenErrorState extends PlaceListScreenState {}
