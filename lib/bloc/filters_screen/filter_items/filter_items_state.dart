part of 'filter_items_bloc.dart';

abstract class FilterItemsState extends Equatable {
  const FilterItemsState();

  @override
  List<Object> get props => [];
}

class FilterItemsDataState extends FilterItemsState {
  final Filter filter;

  FilterItemsDataState({
    required this.filter,
  });

  @override
  List<Object> get props => [
        filter,
      ];
}
