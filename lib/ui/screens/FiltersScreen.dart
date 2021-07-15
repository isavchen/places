import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:places/domain/location.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/styles.dart';
import 'package:places/ui/widget/filter_item.dart';
import 'package:places/ui/widget/slider_radius_search.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  List filterList = [];
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

  bool isPointsNear(Location checkGeo, Location myGeo, double km) {
    var ky = 40000 / 360;
    var kx = cos(pi * myGeo.lat / 180.0) * ky;
    var dx = ((myGeo.lng - checkGeo.lng) * kx).abs();
    var dy = ((myGeo.lat - checkGeo.lat) * ky).abs();
    return sqrt(dx * dx + dy * dy) <= km;
  }

  void filterPlaces() {
    List tempList = [];
    for (final place in mocks) {
      if (((place.type == 'Отель' && _valueHotel) ||
              (place.type == 'Ресторан' && _valueRestourant) ||
              (place.type == 'Особое место' && _valueSpacialPlace) ||
              (place.type == 'Парк' && _valuePark) ||
              (place.type == 'Музей' && _valueMuseum) ||
              (place.type == 'Кафе' && _valueCafe)) &&
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
        leading: Platform.isIOS
            ? Icon(Icons.arrow_back_ios)
            : Icon(Icons.arrow_back),
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
            child: Text("Очистить"),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Text(
              "КАТЕГОРИИ",
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
          Expanded(
            child: Container(),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ElevatedButton(
              onPressed: count == 0 ? null : () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text("ПОКАЗАТЬ ($count)"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
