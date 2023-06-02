class Place {
  int id;
  double lat, lng;
  String name;
  List<String> urls;
  String placeType;
  String description;

  Place({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.urls,
    required this.description,
    required this.placeType,
  });

  Place.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
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
        'urls': urls,
        'description': description,
        'placeType': placeType,
      };

  @override
  String toString() {
    return 'Place id: $id, name: $name, type: $placeType';
  }
}
