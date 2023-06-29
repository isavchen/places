import 'package:equatable/equatable.dart';
import 'package:places/domain/place.dart';

abstract class VisitedEvent extends Equatable {
  const VisitedEvent();

  @override
  List<Object?> get props => [];
}

class VisitedUpdateList extends VisitedEvent {
   final Place place;

   const VisitedUpdateList(this.place);
}

