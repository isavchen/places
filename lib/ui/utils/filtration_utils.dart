import 'package:places/domain/place.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/location.dart';
import 'package:places/ui/utils/get_category_type.dart';
import 'package:places/ui/utils/location_utils.dart';

List<Place> filtrationPlace(
    {required Filter filter,
    required List<Place> incomingList,
    required Location location}) {
  List<Place> outputList = [];
  for (final place in incomingList) {
    if ((filter.categoryType[getCategoryType(place.placeType)] == true) &&
        (isPointsNear(Location(lat: place.lat, lng: place.lng), location,
            filter.radius! / 1000))) outputList.add(place);
  }

  return outputList;
}
