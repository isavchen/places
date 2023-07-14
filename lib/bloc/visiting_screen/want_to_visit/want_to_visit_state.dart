import 'package:equatable/equatable.dart';
import 'package:places/domain/place.dart';

abstract class WantToVisitState extends Equatable {
  const WantToVisitState();

  @override
  List<Object> get props => [];
}

class WantToVisitListUpdatedSuccess extends WantToVisitState {
  final List<Place> places;

  const WantToVisitListUpdatedSuccess({required this.places});

  @override
  List<Object> get props => [places];

  @override
  String toString() => 'WantToVisitListUpdatedSuccess {places: $places}';
}
