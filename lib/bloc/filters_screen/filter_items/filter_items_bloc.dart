import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:places/bloc/filters_screen/filter_button/filter_button_bloc.dart';
import 'package:places/domain/filter.dart';

part 'filter_items_event.dart';
part 'filter_items_state.dart';

class FilterItemsBloc extends Bloc<FilterItemsEvent, FilterItemsState> {
  final FilterButtonBloc _filterButtonBloc;
  FilterItemsBloc(this._filterButtonBloc)
      : super(
          FilterItemsDataState(
            filter: Filter(
              // userLocation: Location(lat: 50.413475, lng: 30.525177),
              // radius: 10000,
              categoryType: {
                CategoryType.temple: true,
                CategoryType.monument: true,
                CategoryType.park: true,
                CategoryType.theatre: true,
                CategoryType.museum: true,
                CategoryType.hotel: true,
                CategoryType.restaurant: true,
                CategoryType.cafe: true,
                CategoryType.other: true,
              },
            ),
          ),
        ) {
    on<ChangeFilter>(_changeFilter);
    on<ClearFilter>(_clearFilter);
  }

  void _changeFilter(ChangeFilter event, Emitter<FilterItemsState> emit) {
    emit(FilterItemsDataState(filter: event.filter));
    _filterButtonBloc.add(LoadFiltratedPlaces(filter: event.filter));
  }

  Future<void> _clearFilter(
      ClearFilter event, Emitter<FilterItemsState> emit) async {
    final state = this.state;
    if (state is FilterItemsDataState) {
      final clearFilter = state.filter.copyWith(
        categoryType: {
          CategoryType.temple: false,
          CategoryType.monument: false,
          CategoryType.park: false,
          CategoryType.theatre: false,
          CategoryType.museum: false,
          CategoryType.hotel: false,
          CategoryType.restaurant: false,
          CategoryType.cafe: false,
          CategoryType.other: false,
        },
      );
      emit(
        FilterItemsDataState(
          filter: clearFilter,
        ),
      );
      _filterButtonBloc.add(LoadFiltratedPlaces(filter: clearFilter));
    }
  }
}
