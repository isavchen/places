import 'package:flutter/material.dart';
import 'package:places/domain/place.dart';
import 'package:places/data/place_model_selector.dart';
import 'package:places/data/repository/placeRepository.dart';

class SearchInteractor extends ChangeNotifier {
  static final PlaceRepository placeRepository = PlaceRepository();

  final List<String> _searchHistory = [];
  final List<Place> _searchResult = [];

  // Get search re
  List<String> get getSeatchHistory => _searchHistory;

  // Get search history
  List<Place> get getSearchResult => _searchResult;

  // Get list of places
  // sorted by distance to user
  Future<void> searchPlaces({required String namePlace}) async {
    final responseDto =
        await placeRepository.getFilteredPlaces(namePlace: namePlace);

    _searchResult.clear();
    _searchResult.addAll(responseDto.map((e) => placeModelFromDtoSelector(e)));

    addToSearchHistory(namePlace);

    notifyListeners();
  }

  void addToSearchHistory(String request) {
    if (_searchHistory.contains(request)) {
      _searchHistory.remove(request);
      _searchHistory.add(request);
    } else {
      _searchHistory.add(request);
    }
  }

  void removeFromSearchHistory(String request) {
    _searchHistory.remove(request);

    notifyListeners();
  }

  void clearSearchHistory() {
    _searchHistory.clear();

    notifyListeners();
  }
}
