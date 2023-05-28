import 'package:places/domain/location.dart';

enum CategoryType {
  temple,
  monument,
  park,
  theatre,
  museum,
  hotel,
  restaurant,
  cafe,
  other
}

class Filter {
  final Location? userLocation;
  final double? radius;
  final String? nameFilter;
  final Map<CategoryType, bool> categoryType;

  Filter({
    this.userLocation,
    this.radius,
    this.nameFilter,
    required this.categoryType,
  });

  String getNameFilter(categoryType) {
    switch (categoryType) {
      case CategoryType.temple:
        return "Храм";
      case CategoryType.monument:
        return "Памятник";
      case CategoryType.park:
        return "Парк";
      case CategoryType.theatre:
        return "Театр";
      case CategoryType.museum:
        return "Музей";
      case CategoryType.hotel:
        return "Отель";
      case CategoryType.restaurant:
        return "Ресторан";
      case CategoryType.cafe:
        return "Кафе";
      case CategoryType.other:
        return "Остальное";
      default:
        return "";
    }
  }

  Filter copyWith({Location? userLocation, double? radius, Map<CategoryType, bool>? categoryType, String? nameFilter}) =>
      Filter(
        userLocation: userLocation ?? this.userLocation,
        radius: radius ?? this.radius,
        categoryType: categoryType ?? this.categoryType,
        nameFilter: nameFilter ?? this.nameFilter
      );
}
