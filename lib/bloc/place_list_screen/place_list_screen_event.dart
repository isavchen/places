part of 'place_list_screen_bloc.dart';

abstract class PlaceListScreenEvent extends Equatable {
  const PlaceListScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadPlacesList extends PlaceListScreenEvent {}

class AddFilteredPlaces extends PlaceListScreenEvent {
  final List<Place> places;

  AddFilteredPlaces({required this.places});

  @override
  List<Object> get props => [places];
}
