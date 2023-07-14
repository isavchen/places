part of 'filter_button_bloc.dart';

abstract class FilterButtonState extends Equatable {
  const FilterButtonState();

  @override
  List<Object> get props => [];
}

class FilterButtonLoadingState extends FilterButtonState {}

class FilterButtonLoadedState extends FilterButtonState {
  final List<Place> places;

  FilterButtonLoadedState({required this.places});
}
