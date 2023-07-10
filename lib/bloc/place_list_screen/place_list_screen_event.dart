part of 'place_list_screen_bloc.dart';

abstract class PlaceListScreenEvent extends Equatable {
  const PlaceListScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadPlacesList extends PlaceListScreenEvent {}
