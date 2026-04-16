import 'package:velo_toulouse_app/model/station.dart';
import '../../model/location.dart';

class StationDto {
  static const String nameKey = 'name';
  static const String locationKey = 'location';

  // Location keys
  static const String latitudeKey = 'latitude';
  static const String longitudeKey = 'longitude';
  static const String areaKey = 'area';
  static const String districtKey = 'district';

  static Station fromJson(String id, Map<String, dynamic> json) {
    assert(json[nameKey] is String);
    assert(json[locationKey] is Map);

    final locationJson = Map<String, dynamic>.from(json[locationKey]);

    assert(locationJson[latitudeKey] is num);
    assert(locationJson[longitudeKey] is num);
    assert(locationJson[areaKey] is String);
    assert(locationJson[districtKey] is String);

    final location = Location(
      latitude: (locationJson[latitudeKey] as num).toDouble(),
      longitude: (locationJson[longitudeKey] as num).toDouble(),
      area: locationJson[areaKey],
      district: locationJson[districtKey],
    );

    return Station(id: id, name: json[nameKey], location: location);
  }
}
