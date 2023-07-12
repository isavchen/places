import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/bloc/filters_screen/filter_button/filter_button_bloc.dart';
import 'package:places/bloc/filters_screen/filter_items/filter_items_bloc.dart';
import 'package:places/bloc/place_list_screen/place_list_screen_bloc.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/domain/filter.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/styles.dart';
import 'package:places/ui/utils/get_category_type.dart';
import 'package:places/ui/widget/filter_item.dart';
import 'package:places/ui/widget/overscroll_glow_absorber.dart';
import 'package:places/ui/widget/slider_radius_search.dart';
import 'package:provider/provider.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  late FilterButtonBloc _filterButtonBloc;
  late FilterItemsBloc _filterItemsBloc;

  @override
  void initState() {
    _filterButtonBloc = FilterButtonBloc(
      context.read<PlaceInteractor>(),
      context.read<PlaceListScreenBloc>(),
    )..add(LoadFiltratedPlaces(
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
      ));
    _filterItemsBloc = FilterItemsBloc(_filterButtonBloc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.sizeOf(context).width;
    final _height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              _filterItemsBloc.add(ClearFilter());
            },
            child: Text('filters.clear_button'.tr()),
          ),
        ],
      ),
      body: SafeArea(
        child: OverscrollGlowAbsorber(
          child: BlocBuilder<FilterItemsBloc, FilterItemsState>(
            bloc: _filterItemsBloc,
            builder: (context, state) {
              if (state is FilterItemsDataState) {
                final filter = state.filter;
                return ListView(
                  physics: Platform.isIOS
                      ? BouncingScrollPhysics()
                      : ClampingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 24.0),
                      child: Text(
                        'filters.categories'.tr(),
                        style: smallText.copyWith(fontSize: 12.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Container(
                        width: double.infinity,
                        height: (_width <= 375 && _height <= 667) ||
                                MediaQuery.orientationOf(context) ==
                                    Orientation.landscape
                            ? 100
                            : 354,
                        child: (_width <= 375 && _height <= 667) ||
                                MediaQuery.orientationOf(context) ==
                                    Orientation.landscape
                            ? ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 92,
                                    width: 92,
                                    child: FilterItem(
                                      category: mocksCategory[index],
                                      value: filter.categoryType[
                                          getCategoryType(mocksCategory[index]
                                              .name
                                              .toLowerCase())]!,
                                      onChanged: (currentValue) {
                                        _filterItemsBloc.add(
                                          ChangeFilter(
                                            filter: filter.copyWith(
                                              categoryType: Map.from(
                                                filter.categoryType.map(
                                                  (key, value) {
                                                    return key ==
                                                            getCategoryType(
                                                                mocksCategory[
                                                                        index]
                                                                    .name
                                                                    .toLowerCase())
                                                        ? MapEntry(
                                                            key, currentValue)
                                                        : MapEntry(key, value);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                                itemCount: mocksCategory.length,
                              )
                            : GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                ),
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: mocksCategory.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 92,
                                    width: 92,
                                    child: FilterItem(
                                      category: mocksCategory[index],
                                      value: filter.categoryType[
                                          getCategoryType(mocksCategory[index]
                                              .name
                                              .toLowerCase())]!,
                                      onChanged: (currentValue) {
                                        _filterItemsBloc.add(
                                          ChangeFilter(
                                            filter: filter.copyWith(
                                              categoryType: Map.from(
                                                filter.categoryType.map(
                                                  (key, value) {
                                                    return key ==
                                                            getCategoryType(
                                                                mocksCategory[
                                                                        index]
                                                                    .name
                                                                    .toLowerCase())
                                                        ? MapEntry(
                                                            key, currentValue)
                                                        : MapEntry(key, value);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: (_width <= 375 && _height <= 667) ||
                                MediaQuery.orientationOf(context) ==
                                    Orientation.landscape
                            ? 24
                            : 56,
                      ),
                      child: SliderRadiusSearch(
                        value: filter.radius ?? 0,
                        onChanged: (currentValue) {
                          _filterItemsBloc.add(ChangeFilter(
                              filter: filter.copyWith(radius: currentValue)));
                        },
                      ),
                    ),
                  ],
                );
              }
              throw ArgumentError(
                  "Wrong state in FiltersScreen for FilterItemsBloc");
            },
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Consumer<PlaceInteractor>(
            builder: (context, placeInteractor, child) {
              return BlocBuilder<FilterButtonBloc, FilterButtonState>(
                bloc: _filterButtonBloc,
                builder: (context, state) {
                  int count = 0;
                  if (state is FilterButtonLoadedState) {
                    count = state.places.length;
                  }
                  return ElevatedButton(
                    onPressed: count != 0
                        ? () {
                            _filterButtonBloc.add(ApplyFilter());
                            Navigator.of(context).pop();
                          }
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        'filters.show_button'.tr(
                          namedArgs: {
                            'count': state is FilterButtonLoadedState
                                ? state.places.length.toString()
                                : '...',
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
