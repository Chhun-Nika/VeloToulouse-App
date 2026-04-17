import 'package:velo_toulouse_app/model/slot.dart';

class SlotDto {
  static const String stationIdKey = 'stationId';
  static const String slotNumberKey = 'slotNumber';
  static const String bikeIdKey = 'bikeId';

  // from json to object
  static Slot fromJson(String id, Map<String, dynamic> json) {
    assert(json[stationIdKey] is String);
    assert(json[slotNumberKey] is String);
    assert(json[bikeIdKey] == null || json[bikeIdKey] is String);

    return Slot(
      id: id,
      stationId: json[stationIdKey],
      slotNumber: json[slotNumberKey],
      bikeId: json[bikeIdKey],
    );
  }

  // convert from object to json
  static Map<String, dynamic> toJson(Slot slot) {
    return {
      stationIdKey: slot.stationId,
      slotNumberKey: slot.slotNumber,
      bikeIdKey: slot.bikeId,
    };
  }
}
