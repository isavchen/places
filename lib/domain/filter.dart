import 'package:equatable/equatable.dart';
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

class Filter extends Equatable {
  final Location? userLocation;
  final double? radius;
  final Map<CategoryType, bool> categoryType;

  Filter({
    this.userLocation,
    this.radius,
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

  Filter copyWith({
    Location? userLocation,
    double? radius,
    Map<CategoryType, bool>? categoryType,
  }) =>
      Filter(
        userLocation: userLocation ?? this.userLocation,
        radius: radius ?? this.radius,
        categoryType: categoryType ?? this.categoryType,
      );

  @override
  String toString() {
    return 'Filter: userLocation(lat: ${userLocation?.lat}, lng: ${userLocation?.lng}), radius: $radius, categoryType: $categoryType';
  }

  @override
  List<Object?> get props => [userLocation, radius, categoryType];
}
