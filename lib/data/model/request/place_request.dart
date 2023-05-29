class PlaceRequest {
  double lat, lng;
  String name;
  List<String> urls;
  String placeType;
  String description;

  PlaceRequest({
    required this.name,
    required this.lat,
    required this.lng,
    required this.urls,
    required this.description,
    required this.placeType,
  });

  PlaceRequest.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        lat = json['lat'],
        lng = json['lng'],
        urls = json["urls"] == null
            ? []
            : List<String>.from(json["urls"].map((x) => x)),
        description = json['description'],
        placeType = json['placeType'];

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
        'name': name,
        'urls': urls,
        'description': description,
        'placeType': placeType,
      };

  @override
  String toString() {
    return 'Place request name: $name, type: $placeType';
  }
}
