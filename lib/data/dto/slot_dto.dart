import 'package:velo_toulouse_app/model/slot.dart';

class SlotDto {
  static const String stationIdKey = 'stationId';
  static const String indexKey = 'index';
  static const String bikeIdKey = 'bikeId';
  static const String statusKey = 'status';

  // from json to object
  static Slot fromJson(String id, Map<String, dynamic> json) {
    assert(json[stationIdKey] is String);
    assert(json[indexKey] is num);
    assert(json[bikeIdKey] == null || json[bikeIdKey] is String);
    assert(json[statusKey] is String);

    return Slot(
      id: id,
      stationId: json[stationIdKey],
      index: (json[indexKey] as num).toInt(),
      bikeId: json[bikeIdKey],
      slotStatus: _getStatus(json[statusKey]),
    );
  }

  // convert from object to json
  static Map<String, dynamic> toJson(Slot slot) {
    return {
      stationIdKey: slot.stationId,
      indexKey: slot.index,
      bikeIdKey: slot.bikeId,
      statusKey: slot.slotStatus.name,
    };
  }

  static SlotStatus _getStatus(String status) {
    switch (status) {
      case 'occupied':
        return SlotStatus.occupied;
      case 'available':
      default:
        return SlotStatus.available;
    }
  }
}
