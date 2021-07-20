import 'dart:math';

import 'package:places/domain/location.dart';

bool isPointsNear(Location checkGeo, Location myGeo, double km) {
    var ky = 40000 / 360;
    var kx = cos(pi * myGeo.lat / 180.0) * ky;
    var dx = ((myGeo.lng - checkGeo.lng) * kx).abs();
    var dy = ((myGeo.lat - checkGeo.lat) * ky).abs();
    return sqrt(dx * dx + dy * dy) <= km;
  }