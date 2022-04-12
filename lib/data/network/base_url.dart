class BaseUrl {
  static const host =
      'https://test-backend-flutter.surfstudio.ru';

  static final _Place place = _Place();
  static final _Media media = _Media();
}

class _Place {
  final String placesUrl = '/place';
  final String filteredPlacesUrl = '/filtered_places';
  String placeById({required String id}) => '/place/$id';
}

class _Media {
  final String upload = '/upload_file';
}
