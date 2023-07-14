part of 'filter_button_bloc.dart';

abstract class FilterButtonEvent extends Equatable {
  const FilterButtonEvent();

  @override
  List<Object> get props => [];
}

class LoadFiltratedPlaces extends FilterButtonEvent {
  final Filter filter;

  LoadFiltratedPlaces({required this.filter});
}

class ApplyFilter extends FilterButtonEvent {}
