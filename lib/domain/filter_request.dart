class FilterRequest {
  double? lat;
  double? lng;
  double? radius;
  List<String>? typeFilter;
  String? nameFilter;

  FilterRequest({
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
        'typeFilter': typeFilter,
        'nameFilter': nameFilter,
      };
}
