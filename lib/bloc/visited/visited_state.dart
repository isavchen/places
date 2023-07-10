import 'package:equatable/equatable.dart';
import 'package:places/domain/place.dart';

abstract class VisitedState extends Equatable {
  const VisitedState();

  @override
  List<Object> get props => [];
}

class VisitedListUpdatedSuccess extends VisitedState {
  final List<Place> places;

  const VisitedListUpdatedSuccess({required this.places});

  @override
  List<Object> get props => [places];

  @override
  String toString() => 'VisitedList {places: $places}';
}
