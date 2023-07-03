import 'package:places/domain/place.dart';

abstract class SearchPlaceAction {}

class FindPlaceAction extends SearchPlaceAction {
  final String request;

  FindPlaceAction({required this.request});
}

class ShowSearchResultAction extends SearchPlaceAction {
  final List<Place> places;

  ShowSearchResultAction({required this.places});
}

class LoadSearchHistoryAction extends SearchPlaceAction {}


class ShowSearchHistoryAction extends SearchPlaceAction {
  final List<String> queries;

  ShowSearchHistoryAction({required this.queries});
}

class RemoveQueryFromHistoryAction extends SearchPlaceAction {
  final String query;

  RemoveQueryFromHistoryAction(this.query);
}

class ClearSearchHistoryAction extends SearchPlaceAction {}

class ShowSearchErrorAction extends SearchPlaceAction {}
