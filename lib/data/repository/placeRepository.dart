import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:places/data/model/request/place_request.dart';
import 'package:places/data/model/request/places_filter_request_dto.dart';
import 'package:places/domain/place.dart';
import 'package:places/data/model/response/place_dto.dart';
import 'package:places/data/network/api_client.dart';
import 'package:places/data/network/base_url.dart';
import 'package:places/domain/filter.dart';
import 'package:places/ui/utils/get_category_type.dart';
import 'package:mime_type/mime_type.dart';

class PlaceRepository {
  final Dio _client = ApiClient.getApiClient();

  //get filtered places
  Future<List<PlaceDto>> getFilteredPlaces({
    Filter? filter,
    String? namePlace,
  }) async {
    late PlacesFilterRequestDto data;

    if (filter != null && filter.userLocation != null && filter.radius != null)
      data = PlacesFilterRequestDto(
        lat: filter.userLocation?.lat,
        lng: filter.userLocation?.lng,
        radius: filter.radius,
        typeFilter: getPlaceTypes(filter.categoryType),
      );
    else
      data = PlacesFilterRequestDto(
        nameFilter: namePlace,
        typeFilter: getPlaceTypes(filter!.categoryType),
      );

    final response = await _client.post(
      BaseUrl.place.filteredPlacesUrl,
      data: jsonEncode(data.toJson()),
    );

    final List<PlaceDto> places = (response.data as List)
        .map((place) => PlaceDto.fromJson(place))
        .toList();

    places.forEach((e) => print(e.toString()));

    return places;
  }

  //get all places
  Future<List<Place>> getPlaces() async {
    final response = await _client.get(
      BaseUrl.place.placesUrl,
    );

    final List<Place> places = (response.data as List<dynamic>)
        .map((place) => Place.fromJson(place as Map<String, dynamic>))
        .toList();

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
  Future<Place> createPlace(PlaceRequest place) async {
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
  Future<Place> updatePlace(Place place) async {
    final response = await _client.put(
      BaseUrl.place.placeById(id: place.id.toString()),
      data: jsonEncode(place.toJson()),
    );

    final Place updatedPlace =
        Place.fromJson(response.data as Map<String, dynamic>);

    print(updatedPlace.toString());
    return updatedPlace;
  }

  //upload photo
  Future<String> uploadPhoto(File image) async {
    String fileName = image.path.split('/').last;
    String? mimeType = mime(fileName);
    String? type = mimeType?.split('/')[0];
    String? subType = mimeType?.split('/')[1];

    if (mimeType != null) {
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          image.path,
          filename: fileName,
          contentType: MediaType(type!, subType!),
        ),
      });
      final response = await _client.post(
        BaseUrl.media.upload,
        data: formData,
      );
      return '${BaseUrl.host}/${response.headers['location']?.first}';
    } else {
      throw Exception("Undefined type of file");
    }
  }
}
