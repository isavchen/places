import 'package:places/domain/filter.dart';
import 'package:places/domain/location.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/utils/get_category_type.dart';
import 'package:places/ui/utils/location_utils.dart';

List<Sight> filtrationPlace(
    {required Filter filter,
    required List<Sight> incomingList,
    required Location location}) {
  List<Sight> outputList = [];
  for (final place in incomingList) {
    if ((filter.categoryType[getCategoryType(place.type)] == true) &&
        (isPointsNear(Location(lat: place.lat, lng: place.lon), location,
            filter.radius / 1000))) outputList.add(place);
  }

  return outputList;
}
