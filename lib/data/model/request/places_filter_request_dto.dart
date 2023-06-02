class PlacesFilterRequestDto {
  double? lat, lng;
  double? radius;
  List<String>? typeFilter;
  String? nameFilter;


  PlacesFilterRequestDto({
    this.lat,
    this.lng,
    this.radius,
    this.typeFilter,
    this.nameFilter,
  });

  Map<String, dynamic> toJson() => {
    'lat': lat,
    'lng': lng,
    'radius': radius,
    'placeType': typeFilter,
    'nameFilter': nameFilter
  };

  @override
  String toString() {
    return 'Places Filter Request Dto lat: $lat, lng: $lng, radius: $radius, nameFilter: $nameFilter, nameFilter: $nameFilter';
  }
}
