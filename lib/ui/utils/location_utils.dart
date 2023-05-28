import 'dart:math';

import 'package:places/domain/location.dart';

bool isPointsNear(Location checkGeo, Location myGeo, double km) {
  var ky = 40000 / 360;
  var kx = cos(pi * myGeo.lat / 180.0) * ky;
  var dx = ((myGeo.lng - checkGeo.lng) * kx).abs();
  var dy = ((myGeo.lat - checkGeo.lat) * ky).abs();
  return sqrt(dx * dx + dy * dy) <= km;
}

double degreesToRadians(degrees) {
  return degrees * pi / 180;
}

double distanceBetweenTwoPoints(lat1, lon1, lat2, lon2) {
  var earthRadiusKm = 6371;

  var dLat = degreesToRadians(lat2 - lat1);
  var dLon = degreesToRadians(lon2 - lon1);

  lat1 = degreesToRadians(lat1);
  lat2 = degreesToRadians(lat2);

  var a = sin(dLat / 2) * sin(dLat / 2) +
      sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);
  var c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return earthRadiusKm * c;
}
