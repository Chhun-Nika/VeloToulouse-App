import 'package:uuid/uuid.dart';

var _uuid = Uuid();

enum SlotStatus { available, occupied}

class Slot {
  final String id;
  final String stationId;
  final int index;
  final String? bikeId;
  final SlotStatus slotStatus;

  Slot({
    String? id,
    required this.stationId,
    required this.index,
    required this.bikeId,
    required this.slotStatus,
  }) : id = id ?? _uuid.v4();
}
