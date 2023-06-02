import 'package:places/domain/filter.dart';

CategoryType getCategoryType(String category) {
  switch (category) {
    case 'temple':
      return CategoryType.temple;
    case 'monument': //
      return CategoryType.monument;
    case 'park':
      return CategoryType.park;
    case 'theatre':
      return CategoryType.theatre;
    case 'museum':
      return CategoryType.museum;
    case 'hotel': //
      return CategoryType.hotel;
    case 'restaurant': //
      return CategoryType.restaurant;
    case 'cafe':
      return CategoryType.cafe;
    case 'other':
      return CategoryType.other;
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
