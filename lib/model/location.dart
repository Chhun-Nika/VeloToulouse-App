class Location {
  final double latitude;
  final double longitude;
  final String area; // e.g. Beong Keng Kang
  final String district; // e.g. Chamkar Mon

  Location({
    required this.latitude,
    required this.longitude,
    required this.area,
    required this.district,
  });

  /// For UI display
  String get shortAddress => '$area, $district';
}
