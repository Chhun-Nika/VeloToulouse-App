import 'package:velo_toulouse_app/model/slot.dart';

abstract class SlotRepository {
  Future<List<Slot>> getSlotsByStation(String stationId);
  Future<List<Slot>> getSlotByBikeId(String bikeId);
}
