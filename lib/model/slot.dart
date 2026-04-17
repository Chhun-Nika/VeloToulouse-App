import 'package:uuid/uuid.dart';

var _uuid = Uuid();

class Slot {
  final String id;
  final String stationId;
  final String slotNumber;
  final String? bikeId;

  Slot({
    String? id,
    required this.stationId,
    required this.slotNumber,
    required this.bikeId,
  }) : id = id ?? _uuid.v4();
}
