part of 'place_details_screen_bloc.dart';

abstract class PlaceDetailsScreenState extends Equatable {
  const PlaceDetailsScreenState();
  
  @override
  List<Object> get props => [];
}

class PlaceDetailsScreenLoadingState extends PlaceDetailsScreenState {}

class PlaceDetailsScreenSuccessState extends PlaceDetailsScreenState {
  final Place place;

  PlaceDetailsScreenSuccessState({required this.place});

  @override
  List<Object> get props => [place];
}

class PlaceDetailsScreenErrorState extends PlaceDetailsScreenState {}
