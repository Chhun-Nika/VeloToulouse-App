import 'package:velo_toulouse_app/model/bike.dart';

class BikeDto {
  static const String stationIdKey = 'stationId';
  static const String bikeCodeKey = 'bikeCode';

  // from json to object
  static Bike fromJson(String id, Map<String, dynamic> json) {
    assert(json[stationIdKey] is String);
    assert(json[bikeCodeKey] is String);

    return Bike(
      id: id,
      stationId: json[stationIdKey],
      bikeCode: json[bikeCodeKey],
    );
  }

  // convert from object to json
  static Map<String, dynamic> toJson(Bike bike) {
    return {
      stationIdKey: bike.stationId,
      bikeCodeKey: bike.bikeCode,
    };
  }
}
