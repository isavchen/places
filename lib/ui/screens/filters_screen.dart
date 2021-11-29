import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/location.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/styles.dart';
import 'package:places/ui/utils/location_utils.dart';
import 'package:places/ui/widget/filter_item.dart';
import 'package:places/ui/widget/overscroll_glow_absorber.dart';
import 'package:places/ui/widget/slider_radius_search.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  List<Sight> filterList = [];
  Location myLocation = Location(lat: 50.413475, lng: 30.525177);
  double _valueDistance = 8500;
  bool _valueHotel = true;
  bool _valueRestourant = true;
  bool _valueSpacialPlace = true;
  bool _valuePark = true;
  bool _valueMuseum = true;
  bool _valueCafe = true;
  int count = 0;

  @override
  void initState() {
    super.initState();
    filterPlaces();
  }

  void filterPlaces() {
    List<Sight> tempList = [];
    for (final place in mocks) {
      if (((place.type == 'отель' && _valueHotel) ||
              (place.type == 'ресторан' && _valueRestourant) ||
              (place.type == 'особое место' && _valueSpacialPlace) ||
              (place.type == 'парк' && _valuePark) ||
              (place.type == 'музей' && _valueMuseum) ||
              (place.type == 'кафе' && _valueCafe)) &&
          (isPointsNear(Location(lat: place.lat, lng: place.lon), myLocation,
              _valueDistance / 1000))) tempList.add(place);
    }
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
                _valueHotel = false;
                _valueRestourant = false;
                _valueSpacialPlace = false;
                _valuePark = false;
                _valueMuseum = false;
                _valueCafe = false;
                _valueDistance = 10000;
              });
              filterPlaces();
            },
            child: Text('filters.clear_button'.tr()),
          ),
        ],
      ),
      body: OverscrollGlowAbsorber(
        child: ListView(
          physics: Platform.isIOS
              ? BouncingScrollPhysics()
              : ClampingScrollPhysics(),
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
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
                  children: [
                    FilterItem(
                      category: mocksCategory[0],
                      value: _valueHotel,
                      onChanged: (currentValue) {
                        setState(() {
                          _valueHotel = currentValue;
                        });
                        filterPlaces();
                      },
                    ),
                    FilterItem(
                      category: mocksCategory[1],
                      value: _valueRestourant,
                      onChanged: (currentValue) {
                        setState(() {
                          _valueRestourant = currentValue;
                        });
                        filterPlaces();
                      },
                    ),
                    FilterItem(
                      category: mocksCategory[2],
                      value: _valueSpacialPlace,
                      onChanged: (currentValue) {
                        setState(() {
                          _valueSpacialPlace = currentValue;
                        });
                        filterPlaces();
                      },
                    ),
                    FilterItem(
                      category: mocksCategory[3],
                      value: _valuePark,
                      onChanged: (currentValue) {
                        setState(() {
                          _valuePark = currentValue;
                        });
                        filterPlaces();
                      },
                    ),
                    FilterItem(
                      category: mocksCategory[4],
                      value: _valueMuseum,
                      onChanged: (currentValue) {
                        setState(() {
                          _valueMuseum = currentValue;
                        });
                        filterPlaces();
                      },
                    ),
                    FilterItem(
                      category: mocksCategory[5],
                      value: _valueCafe,
                      onChanged: (currentValue) {
                        setState(() {
                          _valueCafe = currentValue;
                        });
                        filterPlaces();
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
                value: _valueDistance,
                onChanged: (currentValue) {
                  setState(() {
                    _valueDistance = currentValue;
                  });
                  filterPlaces();
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ElevatedButton(
            onPressed: count == 0
                ? null
                : () {
                    Navigator.of(context).pop(filterList);
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
