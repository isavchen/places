import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/network/api_client.dart';
import 'package:places/data/network/base_url.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/filter_request.dart';
import 'package:places/domain/location.dart';
import 'package:places/ui/utils/get_category_type.dart';

class PlaceRepository {
  final Dio _client = ApiClient.getApiClient();

  //get filtered places
  Future<List<Place>> getFilteredPlaces({
    required Location? geolocation,
    required Filter? filter,
    required String? nameFilter,
  }) async {
    late FilterRequest data;

    if (geolocation != null)
      data = FilterRequest(
        lat: geolocation.lat,
        lng: geolocation.lng,
        radius: filter!.radius,
        typeFilter: getPlaceTypes(filter.categoryType),
        nameFilter: nameFilter != null ? nameFilter.trim() : null,
      );
    else
      data = FilterRequest(
        nameFilter: nameFilter != null ? nameFilter.trim() : null,
      );

    final response = await _client.post(
      BaseUrl.place.filteredPlacesUrl,
      data: jsonEncode(data.toJson()),
    );

    final List<Place> places =
        (response.data as List).map((place) => Place.fromJson(place)).toList();

    places.forEach((e) => print(e.toString()));

    return places;
  }

  //get all places
  Future<List<Place>> getPlaces() async {
    final response = await _client.get(
      BaseUrl.place.placesUrl,
    );

    final List<Place> places =
        (response.data as List).map((place) => Place.fromJson(place)).toList();

    places.forEach((e) => print(e.toString()));

    return places;
  }

  //get place by id
  Future<Place> getPlaceById({required String id}) async {
    final response = await _client.get(
      BaseUrl.place.placeById(id: id),
    );

    final Place place = Place.fromJson(response.data);

    print(place.toString());

    return place;
  }

  //create new place
  Future<Place> createPlace(Place place) async {
    final response = await _client.post(
      BaseUrl.place.placesUrl,
      data: jsonEncode(place.toJson()),
    );

    final Place newPlace =
        Place.fromJson((response.data as Map<String, dynamic>));

    print(newPlace.toString());

    return newPlace;
  }

  //remove place
  Future<void> removePlace({required String id}) async {
    await _client.delete(BaseUrl.place.placeById(id: id));
  }

  //update place
  Future<void> updatePlace(Place place) async {
    await _client.put(
      BaseUrl.place.placeById(id: place.id.toString()),
      data: jsonEncode(place.toJson()),
    );
  }

  //upload photo
  Future<void> uploadPhoto(File image) async {
    //TODO: check image type
    await _client.post(
      BaseUrl.media.upload,
      //TODO: add image FormData
      // data: FormData.fromMap(map),
    );
  }
}
