class PlaceDto {
  int id;
  double lat, lng;
  String name;
  double? distance;
  List<String> urls;
  String placeType;
  String description;

  PlaceDto({
    required this.id,
    required this.name,
    this.distance,
    required this.lat,
    required this.lng,
    required this.urls,
    required this.description,
    required this.placeType,
  });

  PlaceDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        distance = json['distance'],
        lat = json['lat'],
        lng = json['lng'],
        urls = json["urls"] == null
            ? []
            : List<String>.from(json["urls"].map((x) => x)),
        description = json['description'],
        placeType = json['placeType'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'lat': lat,
        'lng': lng,
        'name': name,
        'distance': distance,
        'urls': urls,
        'description': description,
        'placeType': placeType,
      };

  @override
  String toString() {
    return 'Place id: $id, name: $name, type: $placeType';
  }
}
