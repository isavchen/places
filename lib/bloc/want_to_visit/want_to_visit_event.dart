import 'package:equatable/equatable.dart';
import 'package:places/domain/place.dart';

abstract class WantToVisitEvent extends Equatable {
  const WantToVisitEvent();

  @override
  List<Object?> get props => [];
}

class WantToVisitUpdateList extends WantToVisitEvent {
  final Place place;

  const WantToVisitUpdateList(this.place);
}
