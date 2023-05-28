import 'package:places/data/model/response/place.dart';
import 'package:places/data/model/response/place_dto.dart';

Place placeModelFromDtoSelector(PlaceDto placeDto) {
  return Place(
      id: placeDto.id,
      name: placeDto.name,
      lat: placeDto.lat,
      lng: placeDto.lng,
      urls: placeDto.urls,
      description: placeDto.description,
      placeType: placeDto.placeType);
}
