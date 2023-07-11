import 'package:dio/dio.dart';
import 'package:places/domain/place.dart';
import 'package:places/data/place_model_selector.dart';
import 'package:places/data/repository/placeRepository.dart';

class SearchInteractor {
  static final PlaceRepository placeRepository = PlaceRepository();
  
  // Get list of places
  // sorted by distance to user
  Future<List<Place>> searchPlaces({required String namePlace}) async {
    try {
      final responseDto =
          await placeRepository.getFilteredPlaces(namePlace: namePlace);

      final res = responseDto.map((e) => placeModelFromDtoSelector(e)).toList();
      return res;
    } on DioError catch (e) {
      throw placeRepository.getNetworkException(e);
    }
  }
}
