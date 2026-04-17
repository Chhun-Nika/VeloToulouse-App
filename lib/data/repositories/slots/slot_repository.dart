import 'package:velo_toulouse_app/model/slot.dart';

abstract class SlotRepository {
  Future<List<Slot>> getSlotsByStation(String stationId);
  Future<Slot?> getSlotById(String stationId, String slotId);
  Future<void> markSlotAsAvailable({
    required String stationId,
    required String slotId,
  });
}
