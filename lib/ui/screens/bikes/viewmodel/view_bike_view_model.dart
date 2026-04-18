import 'package:flutter/widgets.dart';
import 'package:velo_toulouse_app/data/repositories/bikes/bike_repository.dart';
import 'package:velo_toulouse_app/data/repositories/slots/slot_repository.dart';
import 'package:velo_toulouse_app/model/bike.dart';
import 'package:velo_toulouse_app/model/slot.dart';
import 'package:velo_toulouse_app/ui/utils/async_value.dart';

class ViewBikeViewModel extends ChangeNotifier {
  final BikeRepository bikeRepository;
  final SlotRepository slotRepository;
  final String stationId;

  AsyncValue<List<BikeSlotItem>> bikesValue = AsyncValue.loading();
  BikeSlotItem? selectedItem;

  ViewBikeViewModel({
    required this.bikeRepository,
    required this.slotRepository,
    required this.stationId,
  }) {
    _init();
  }

  void _init() {
    fetchBikeSlotItems(stationId);
  }

  Future<void> fetchBikeSlotItems(String stationId) async {
    bikesValue = AsyncValue.loading();
    notifyListeners();

    try {
      List<Slot> slots = await slotRepository.getSlotsByStation(stationId);
      List<BikeSlotItem> result = [];

      for (var slot in slots) {
        Bike? bike;

        if (slot.bikeId != null) {
          bike = await bikeRepository.getBikeById(stationId, slot.bikeId!);
        }

        result.add(BikeSlotItem(slot: slot, bike: bike));
      }

      bikesValue = AsyncValue.success(result);
      notifyListeners();
    } catch (e) {
      bikesValue = AsyncValue.error(e);
      notifyListeners();
    }
  }

  void selectItem(BikeSlotItem item) {
    if (!isAvailable(item)) {
      return;
    }

    selectedItem = item;
    notifyListeners();
  }

  bool isItemSelected(BikeSlotItem item) {
    return selectedItem?.slot.id == item.slot.id;
  }

  bool isAvailable(BikeSlotItem item) {
    return item.hasBike && item.slot.slotStatus == SlotStatus.occupied;
  }
}

class BikeSlotItem {
  final Slot slot;
  final Bike? bike;

  BikeSlotItem({required this.slot, required this.bike});

  bool get hasBike => bike != null;
  bool get isEmpty => bike == null || slot.slotStatus == SlotStatus.available;
}


