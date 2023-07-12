part of 'filter_items_bloc.dart';

abstract class FilterItemsEvent extends Equatable {
  const FilterItemsEvent();

  @override
  List<Object> get props => [];
}

class ChangeFilter extends FilterItemsEvent {
  final Filter filter;

  ChangeFilter({required this.filter});
}

class ClearFilter extends FilterItemsEvent {}
