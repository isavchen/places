import 'package:places/domain/filter.dart';

CategoryType getCategoryType(String category) {
  switch (category) {
    case 'отель':
      return CategoryType.hotel;
    case 'ресторан':
      return CategoryType.restaurant;
    case 'особое место':
      return CategoryType.star;
    case 'парк':
      return CategoryType.park;
    case 'музей':
      return CategoryType.myseum;
    case 'кафе':
      return CategoryType.cafe;
    default:
      return CategoryType.star;
  }
}