import 'package:velo_toulouse_app/model/bike.dart';

class BikeDto {
  static const String bikeCodeKey = 'bikeCode';
  static const String statusKey = 'status';

  // from json to object
  static Bike fromJson(String id, Map<String, dynamic> json) {
    assert(json[bikeCodeKey] is String);
    assert(json[statusKey] is String);

    return Bike(
      id: id,
      bikeCode: json[bikeCodeKey],
      bikeStatus: _getStatus(json[statusKey]),
    );
  }

  // convert from object to json
  static Map<String, dynamic> toJson(Bike bike) {
    return {
      bikeCodeKey: bike.bikeCode,
      statusKey: bike.bikeStatus.name,
    };
  }

  // get bike status
  static BikeStatus _getStatus(String status) {
    switch (status) {
      case 'booked':
        return BikeStatus.booked;
      case 'available':
        return BikeStatus.available;
      case 'maintenance':
        return BikeStatus.maintenance;
      default:
        return BikeStatus.available; // fallback if the status is invalid
    }
  }
}
