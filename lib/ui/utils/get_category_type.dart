import 'package:places/domain/filter.dart';

CategoryType getCategoryType(String category) {
  switch (category) {
    case 'храм':
      return CategoryType.temple;
    case 'памятник':
      return CategoryType.monument;
    case 'особое место':
      return CategoryType.park;
    case 'парк':
      return CategoryType.theatre;
    case 'музей':
      return CategoryType.museum;
    case 'кафе':
      return CategoryType.hotel;
    case 'кафе':
      return CategoryType.restaurant;
    case 'кафе':
      return CategoryType.cafe;
    default:
      return CategoryType.other;
  }
}

List<String>? getPlaceTypes(Map<CategoryType, bool> categoryTypes) {
  List<String> placeTypes = [];
  categoryTypes.forEach((type, value) {
    if (value == true)
      placeTypes.add(
        getPlaceType(type),
      );
  });
  return placeTypes.isNotEmpty ? placeTypes : null;
}

String getPlaceType(CategoryType type) {
  switch (type) {
    case CategoryType.temple:
      return 'temple';
    case CategoryType.monument:
      return 'monument';
    case CategoryType.park:
      return 'park';
    case CategoryType.theatre:
      return 'theatre';
    case CategoryType.museum:
      return 'museum';
    case CategoryType.hotel:
      return 'hotel';
    case CategoryType.restaurant:
      return 'restaurant';
    case CategoryType.cafe:
      return 'cafe';
    default:
      return 'other';
  }
}
