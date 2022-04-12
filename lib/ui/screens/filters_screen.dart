import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/location.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/styles.dart';
import 'package:places/ui/utils/filtration_utils.dart';
import 'package:places/ui/utils/get_category_type.dart';
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
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                filter = filter.copyWith(categoryType: {
                  CategoryType.temple: false,
                  CategoryType.monument: false,
                  CategoryType.park: false,
                  CategoryType.theatre: false,
                  CategoryType.museum: false,
                  CategoryType.hotel: false,
                  CategoryType.restaurant: false,
                  CategoryType.cafe: false,
                  CategoryType.other: false,
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
                  height: (_width <= 375 && _height <= 667) ||
                          MediaQuery.of(context).orientation ==
                              Orientation.landscape
                      ? 100
                      : 324,
                  child: (_width <= 375 && _height <= 667) ||
                          MediaQuery.of(context).orientation ==
                              Orientation.landscape
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 92,
                              width: 92,
                              child: FilterItem(
                                category: mocksCategory[index],
                                value: filter.categoryType[getCategoryType(
                                    mocksCategory[index].name.toLowerCase())]!,
                                onChanged: (currentValue) {
                                  setState(() {
                                    filter = filter.copyWith(
                                      categoryType: Map.from(
                                        filter.categoryType.map(
                                          (key, value) {
                                            return key ==
                                                    getCategoryType(
                                                        mocksCategory[index]
                                                            .name
                                                            .toLowerCase())
                                                ? MapEntry(key, currentValue)
                                                : MapEntry(key, value);
                                          },
                                        ),
                                      ),
                                    );
                                  });
                                  _filtrationPlace();
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
                                value: filter.categoryType[getCategoryType(
                                    mocksCategory[index].name.toLowerCase())]!,
                                onChanged: (currentValue) {
                                  setState(() {
                                    filter = filter.copyWith(
                                      categoryType: Map.from(
                                        filter.categoryType.map(
                                          (key, value) {
                                            return key ==
                                                    getCategoryType(
                                                        mocksCategory[index]
                                                            .name
                                                            .toLowerCase())
                                                ? MapEntry(key, currentValue)
                                                : MapEntry(key, value);
                                          },
                                        ),
                                      ),
                                    );
                                  });
                                  _filtrationPlace();
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
                          MediaQuery.of(context).orientation ==
                              Orientation.landscape
                      ? 24
                      : 56,
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
