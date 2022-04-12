enum CategoryType {temple, monument,park,theatre, museum, hotel, restaurant, cafe, other }

class Filter {
  final double radius;
  final Map<CategoryType, bool> categoryType;

  Filter({
    required this.radius,
    required this.categoryType,
  });

  Filter copyWith({double? radius, Map<CategoryType, bool>? categoryType}) =>
      Filter(
        radius: radius ?? this.radius,
        categoryType: categoryType ?? this.categoryType,
      );
}
