import 'package:velo_toulouse_app/model/station.dart';

class StationDto {
  static const String nameKey = 'name';
  static const String latitudeKey = 'latitude';
  static const String longtitudeKey = 'longtitude';

  static Station fromJson(String id,Map<String, dynamic> json) {
    assert(json[nameKey] is String);
    assert(json[latitudeKey] is double);
    assert(json[longtitudeKey] is double);

    return Station(
      id: id,
      name: json[nameKey],
      latitude: json[latitudeKey],
      longtitude: json[longtitudeKey],
    );
  }
}
