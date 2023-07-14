import 'dart:io';

import 'package:dio/dio.dart';
import 'package:places/data/model/request/place_request.dart';
import 'package:places/domain/place.dart';
import 'package:places/data/place_model_selector.dart';
import 'package:places/data/repository/placeRepository.dart';
import 'package:places/domain/filter.dart';

class PlaceInteractor {
  static final PlaceRepository placeRepository = PlaceRepository();

  //Get list of filtrated places
  Future<List<Place>> filtrationPlaces({required Filter filter}) async {
    print(filter.toString());
    try {
      final responseDto =
          await placeRepository.getFilteredPlaces(filter: filter);

      if (filter.radius != null || filter.userLocation != null)
        responseDto.sort(((a, b) => a.distance!.compareTo(b.distance!)));

      final places =
          responseDto.map((e) => placeModelFromDtoSelector(e)).toList();

      return places;
    } on DioError catch (e) {
      throw placeRepository.getNetworkException(e);
    }
  }

  // Get not filtered list of places
  Future<List<Place>> getAllPlaces() async {
    try {
      final response = await placeRepository.getPlaces();

      return response;
    } on DioError catch (e) {
      throw placeRepository.getNetworkException(e);
    }
  }

  // Get place details by id
  Future<Place> getPlaceDetails({required int id}) async {
    try {
      final response = await placeRepository.getPlaceById(id: id.toString());

      return response;
    } on DioError catch (e) {
      throw placeRepository.getNetworkException(e);
    }
  }

  //Add image of place
  Future<String> addImage({required File image}) async {
    try {
      final response = await placeRepository.uploadPhoto(image);

      return response;
    } on DioError catch (e) {
      throw placeRepository.getNetworkException(e);
    }
  }

  // Add new place
  Future<Place> addNewPlace({required PlaceRequest place}) async {
    try {
      final response = await placeRepository.createPlace(place);

      return response;
    } on DioError catch (e) {
      throw placeRepository.getNetworkException(e);
    }
  }

  //Update place
  Future<Place> updatePlace({required Place place}) async {
    try {
      final response = await placeRepository.updatePlace(place);

      return response;
    } on DioError catch (e) {
      throw placeRepository.getNetworkException(e);
    }
  }

  //Delete place
  Future<void> removePlace({required String id}) async {
    try {
      await placeRepository.removePlace(id: id);
    } on DioError catch (e) {
      throw placeRepository.getNetworkException(e);
    }
  }
}
