part of 'place_details_screen_bloc.dart';

abstract class PlaceDetailsScreenEvent extends Equatable {
  const PlaceDetailsScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadPlaceDetails extends PlaceDetailsScreenEvent {
  final int id;

  LoadPlaceDetails({required this.id});
}
