class Sight {
  String name;
  double lat, lon;
  String url;
  String? details;
  String? type;

  Sight(
      {required this.name,
      required this.lat,
      required this.lon,
      required this.url,
      this.details,
      this.type});
}
