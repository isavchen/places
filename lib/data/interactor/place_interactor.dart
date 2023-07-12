import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:places/data/model/request/place_request.dart';
import 'package:places/domain/place.dart';
import 'package:places/data/place_model_selector.dart';
import 'package:places/data/repository/placeRepository.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/location.dart';
import 'package:places/ui/utils/location_utils.dart';

class PlaceInteractor extends ChangeNotifier {
  static final PlaceRepository placeRepository = PlaceRepository();
  List<Place> _places = [];
  List<Place> _favouritePlacesList = [];
  List<Place> _visitedPlacesList = [];
  List<String> _uploadedImages = [];

  // Get _places list
  List<Place> get getPlaces => _places;

  // Get visited places list
  List<Place> get getVisitedPlaces => _visitedPlacesList;

  // Get favourite places list
  List<Place> get getFavouritePlacesList => _favouritePlacesList;

  // Get uploaded images list
  List<String> get getUploadedImagesList => _uploadedImages;

  //Get list of filtrated places
  Future<void> filtrationPlaces({required Filter filter}) async {
    try {
      final responseDto =
          await placeRepository.getFilteredPlaces(filter: filter);

      if (filter.radius != null || filter.userLocation != null)
        responseDto.sort(((a, b) => a.distance!.compareTo(b.distance!)));

      _places.clear();
      _places.addAll(responseDto.map((e) => placeModelFromDtoSelector(e)));
      notifyListeners();
    } on DioError catch (e) {
      throw placeRepository.getNetworkException(e);
    }
  }

  // Get not filtered list of places
  Future<List<Place>> getAllPlaces() async {
    try {
      final response = await placeRepository.getPlaces();

      _places.clear();
      _places.addAll(response);

      notifyListeners();

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

  // Get list of favourite places
  // sorted by distance to user
  List<Place> getFavouritesPlaces({required Location? userLocation}) {
    var places = _favouritePlacesList;
    if (userLocation != null) {
      places.sort(((a, b) {
        var distanceToA = distanceBetweenTwoPoints(
            userLocation.lat, userLocation.lng, a.lat, a.lat);
        var distanceToB = distanceBetweenTwoPoints(
            userLocation.lat, userLocation.lng, b.lat, b.lat);
        return distanceToA.compareTo(distanceToB);
      }));
      _favouritePlacesList.clear();
      _favouritePlacesList.addAll(places);
      notifyListeners();
    }

    return _favouritePlacesList;
  }

  // Add place to favourite
  void addToFavourites({required Place place}) {
    if (!_favouritePlacesList.any((element) => element.id == place.id)) {
      _favouritePlacesList.add(place);
      notifyListeners();
    }
  }

  // Remove place from favourite
  void removeFromFavourites({required Place place}) {
    _favouritePlacesList.removeWhere((element) => element.id == place.id);
    notifyListeners();
  }

  // Add place to list of visited places
  void addToVisitedPlaces({required Place place}) {
    if (!_visitedPlacesList.any((element) => element.id == place.id)) {
      _visitedPlacesList.add(place);
      notifyListeners();
    }
  }

  // Remove place from list of visited places
  void removeFromVisitedList({required Place place}) {
    _visitedPlacesList.removeWhere((element) => element.id == place.id);

    notifyListeners();
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

  //Remove image from list place
  Future<void> deleteImage({required String image}) async {
    _uploadedImages.remove(image);
    notifyListeners();
  }

  // Add new place
  Future<Place> addNewPlace({required PlaceRequest place}) async {
    try {
      place.urls.addAll(_uploadedImages);

      final response = await placeRepository.createPlace(place);
      _uploadedImages.clear();

      return response;
    } on DioError catch (e) {
      throw placeRepository.getNetworkException(e);
    }
  }

  //Update place
  Future<Place> updatePlace({required Place place}) async {
    try {
      final response = await placeRepository.updatePlace(place);

      _places[_places.indexOf(place)] = response;
      notifyListeners();
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
