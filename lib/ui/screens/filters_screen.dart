import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/location.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/styles.dart';
import 'package:places/ui/utils/filtration_utils.dart';
import 'package:places/ui/widget/filter_item.dart';
import 'package:places/ui/widget/overscroll_glow_absorber.dart';
import 'package:places/ui/widget/slider_radius_search.dart';

class FiltersScreen extends StatefulWidget {
  final Filter filter;
  const FiltersScreen({Key? key, required this.filter}) : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  List<Sight> filterList = [];
  Location myLocation = Location(lat: 50.413475, lng: 30.525177);
  late Filter filter;
  int count = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      filter = widget.filter;
    });
    _filtrationPlace();
  }

  void _filtrationPlace() {
    List<Sight> tempList = filtrationPlace(
        filter: filter, incomingList: mocks, location: myLocation);

    setState(() {
      filterList = tempList;
      count = filterList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                filter = filter.copyWith(categoryType: {
                  CategoryType.cafe: false,
                  CategoryType.hotel: false,
                  CategoryType.myseum: false,
                  CategoryType.park: false,
                  CategoryType.restaurant: false,
                  CategoryType.star: false,
                }, radius: 10000);
              });
              _filtrationPlace();
            },
            child: Text('filters.clear_button'.tr()),
          ),
        ],
      ),
      body: SafeArea(
        child: OverscrollGlowAbsorber(
          child: ListView(
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
                  height: 214,
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 40.0,
                    children: [
                      FilterItem(
                        category: mocksCategory[0],
                        value: filter.categoryType[CategoryType.hotel]!,
                        onChanged: (currentValue) {
                          setState(() {
                            filter = filter.copyWith(
                              categoryType: {
                                CategoryType.cafe:
                                    filter.categoryType[CategoryType.cafe]!,
                                CategoryType.hotel: currentValue,
                                CategoryType.myseum:
                                    filter.categoryType[CategoryType.myseum]!,
                                CategoryType.park:
                                    filter.categoryType[CategoryType.park]!,
                                CategoryType.restaurant: filter
                                    .categoryType[CategoryType.restaurant]!,
                                CategoryType.star:
                                    filter.categoryType[CategoryType.star]!,
                              },
                            );
                          });
                          _filtrationPlace();
                        },
                      ),
                      FilterItem(
                        category: mocksCategory[1],
                        value: filter.categoryType[CategoryType.restaurant]!,
                        onChanged: (currentValue) {
                          setState(() {
                            filter = filter.copyWith(
                              categoryType: {
                                CategoryType.cafe:
                                    filter.categoryType[CategoryType.cafe]!,
                                CategoryType.hotel:
                                    filter.categoryType[CategoryType.hotel]!,
                                CategoryType.myseum:
                                    filter.categoryType[CategoryType.myseum]!,
                                CategoryType.park:
                                    filter.categoryType[CategoryType.park]!,
                                CategoryType.restaurant: currentValue,
                                CategoryType.star:
                                    filter.categoryType[CategoryType.star]!,
                              },
                            );
                          });
                          _filtrationPlace();
                        },
                      ),
                      FilterItem(
                        category: mocksCategory[2],
                        value: filter.categoryType[CategoryType.star]!,
                        onChanged: (currentValue) {
                          setState(() {
                            filter = filter.copyWith(
                              categoryType: {
                                CategoryType.cafe:
                                    filter.categoryType[CategoryType.cafe]!,
                                CategoryType.hotel:
                                    filter.categoryType[CategoryType.hotel]!,
                                CategoryType.myseum:
                                    filter.categoryType[CategoryType.myseum]!,
                                CategoryType.park:
                                    filter.categoryType[CategoryType.park]!,
                                CategoryType.restaurant: filter
                                    .categoryType[CategoryType.restaurant]!,
                                CategoryType.star: currentValue,
                              },
                            );
                          });
                          _filtrationPlace();
                        },
                      ),
                      FilterItem(
                        category: mocksCategory[3],
                        value: filter.categoryType[CategoryType.park]!,
                        onChanged: (currentValue) {
                          setState(() {
                            filter = filter.copyWith(
                              categoryType: {
                                CategoryType.cafe:
                                    filter.categoryType[CategoryType.cafe]!,
                                CategoryType.hotel:
                                    filter.categoryType[CategoryType.hotel]!,
                                CategoryType.myseum:
                                    filter.categoryType[CategoryType.myseum]!,
                                CategoryType.park: currentValue,
                                CategoryType.restaurant: filter
                                    .categoryType[CategoryType.restaurant]!,
                                CategoryType.star:
                                    filter.categoryType[CategoryType.star]!,
                              },
                            );
                          });
                          _filtrationPlace();
                        },
                      ),
                      FilterItem(
                        category: mocksCategory[4],
                        value: filter.categoryType[CategoryType.myseum]!,
                        onChanged: (currentValue) {
                          setState(() {
                            filter = filter.copyWith(
                              categoryType: {
                                CategoryType.cafe:
                                    filter.categoryType[CategoryType.cafe]!,
                                CategoryType.hotel:
                                    filter.categoryType[CategoryType.hotel]!,
                                CategoryType.myseum: currentValue,
                                CategoryType.park:
                                    filter.categoryType[CategoryType.park]!,
                                CategoryType.restaurant: filter
                                    .categoryType[CategoryType.restaurant]!,
                                CategoryType.star:
                                    filter.categoryType[CategoryType.star]!,
                              },
                            );
                          });
                          _filtrationPlace();
                        },
                      ),
                      FilterItem(
                        category: mocksCategory[5],
                        value: filter.categoryType[CategoryType.cafe]!,
                        onChanged: (currentValue) {
                          setState(() {
                            filter = filter.copyWith(
                              categoryType: {
                                CategoryType.cafe: currentValue,
                                CategoryType.hotel:
                                    filter.categoryType[CategoryType.hotel]!,
                                CategoryType.myseum:
                                    filter.categoryType[CategoryType.myseum]!,
                                CategoryType.park:
                                    filter.categoryType[CategoryType.park]!,
                                CategoryType.restaurant: filter
                                    .categoryType[CategoryType.restaurant]!,
                                CategoryType.star:
                                    filter.categoryType[CategoryType.star]!,
                              },
                            );
                          });
                          _filtrationPlace();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 56,
                ),
                child: SliderRadiusSearch(
                  value: filter.radius,
                  onChanged: (currentValue) {
                    setState(() {
                      filter = filter.copyWith(radius: currentValue);
                    });
                    _filtrationPlace();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ElevatedButton(
            onPressed: count == 0
                ? null
                : () {
                    Navigator.of(context).pop(filter);
                  },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                'filters.show_button'.tr(
                  namedArgs: {
                    'count': count.toString(),
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
